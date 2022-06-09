//
//  MessageDetailsViewController.swift
//  MessageListApp
//
//  Created by Максим Шмидт on 06.06.2022.
//

import UIKit

final class MessageDetailsViewController: UIViewController {
    
 //MARK: - Properties
    
    lazy var messageFromUser = makeMessageLabel()
    lazy var userName = makeNameLabel()
    lazy var userAvatar = makeAvatar()
    lazy var UIPointer = makeUIPointerLabel()
    
    var messageData: String?
    var nameUserData: String?
    var avatarData: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
    }
}

private extension MessageDetailsViewController {
    
    func makeAvatar() -> UIImageView {
        let view = UIImageView()
        view.image = avatarData
        view.layer.cornerRadius = 110
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeNameLabel() -> UILabel {
        let view = UILabel()
        view.text = nameUserData
        view.font = .systemFont(ofSize: 35)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeMessageLabel() -> UILabel {
        let view = UILabel()
        view.text = messageData
        view.numberOfLines = 0
        view.sizeToFit()
        view.font = .systemFont(ofSize: 29)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeUIPointerLabel() -> UILabel {
        let view = UILabel()
        view.text = "Сообщает:"
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func setupUI() {
        view.addSubview(userName)
        view.addSubview(userAvatar)
        view.addSubview(UIPointer)
        view.addSubview(messageFromUser)
        makeConstraints()
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            userAvatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userAvatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            userAvatar.heightAnchor.constraint(equalToConstant: 240),
            userAvatar.widthAnchor.constraint(equalToConstant: 240),
            
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userName.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 30),
            
            UIPointer.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 30),
            UIPointer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            
            messageFromUser.topAnchor.constraint(equalTo: UIPointer.bottomAnchor, constant: 12),
            messageFromUser.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            messageFromUser.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -8)
        ])
    }
}
