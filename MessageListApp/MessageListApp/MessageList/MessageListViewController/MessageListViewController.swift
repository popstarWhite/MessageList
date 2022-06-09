//
//  MessageListViewController.swift
//  MessageListApp
//
//  Created by Максим Шмидт on 01.06.2022.
//

import UIKit

final class MessageListViewController: UIViewController {
    
 // MARK: - Properties
    
    private var cachedMessages: [Message] = [
        .init(
            senderName: "Жора Орлов",
            message: "Салют!",
            image: UIImage(named: "ProfilePhoto_13") ?? UIImage()
        ),
        .init(
            senderName: "Эмма Васильевна",
            message: "Какой у нас дедлайн? Сдали работу?",
            image: UIImage(named: "ProfilePhoto_9") ?? UIImage()
        )
    ]
    
    private lazy var tableView = makeTableView()
    private let networkMessagesManager = NetworkMessagesManager()
    private let stringParser = StringParser()
    
    private let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        return refreshControl
    }()
    
    
    var messageFromAPI: [String] = []
    var randomNames: [String] = []
    var randomAvatars: [UIImage] = []
    
 // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

 //MARK: - UITableViewDelegate & UITableViewDataSource

extension MessageListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messageFromAPI.isEmpty ? cachedMessages.count : messageFromAPI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MessageTableViewCell.identifier,
            for: indexPath
        ) as? MessageTableViewCell else {
            return UITableViewCell()
        }
        if messageFromAPI.isEmpty {
            cell.configure(model: cachedMessages[indexPath.row])
            return cell
        } else {
            let message = messageFromAPI[indexPath.row]
            let name = randomNames[indexPath.row]
            let avatar = randomAvatars[indexPath.row]
            let cellModel = Message(senderName: name, message: message, image: avatar)
            cell.configure(model: cellModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = MessageDetailsViewController()
        
        let currentMesage = messageFromAPI[indexPath.row]
        let currenName = randomNames[indexPath.row]
        let currentAvatar = randomAvatars[indexPath.row]
            controller.messageData = currentMesage
            controller.nameUserData = currenName
            controller.avatarData = currentAvatar
            navigationController?.pushViewController(controller, animated: true)
        }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}

 // MARK: - SetupUI

private extension MessageListViewController {
    
    func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.identifier)
        return tableView
    }
    
    func setupNavigationBar() {
        title = "Тестовое задание"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.addSubview(myRefreshControl)
        setupNavigationBar()
        makeConstraints()
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc
    func refreshTableView() {
        loadData()
        myRefreshControl.endRefreshing()
    }
    
    
    func getRandomAvatar() -> UIImage {
        UIImage(named: "ProfilePhoto_\(Int.random(in: 1...20))") ?? UIImage()
    }
}
    
 //MARK: - Loading Data

private extension MessageListViewController {
    
    func loadData() {
        loadMessages()
        loadNames()
        loadAvatars()
        tableView.reloadData()
    }
    
    func loadMessages() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.networkMessagesManager.fetchReceviedMessage() { receviedMessages in
                self.messageFromAPI = receviedMessages.receivedMessages.reversed()
            }
        }
    }
    
    func loadNames() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.stringParser.parseFromFile("NamesList") { names in
                guard let names = names, !names.isEmpty else { return }
                self.randomNames = names
                if self.randomNames.count != self.messageFromAPI.count {
                    let diff = self.randomNames.count - self.messageFromAPI.count
                    self.randomNames = self.randomNames.dropLast(diff)
                }
            }
        }
    }
    
    func loadAvatars() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            for _ in 0...self.messageFromAPI.count {
                self.randomAvatars.append(
                    .init(
                        named: "ProfilePhoto_\(Int.random(in: 1...20))"
                    ) ?? UIImage()
                )
            }
        }
    }
}
