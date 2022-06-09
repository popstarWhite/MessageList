//
//  MessageTableViewCell.swift
//  MessageListApp
//
//  Created by Максим Шмидт on 01.06.2022.
//

import UIKit

final class MessageTableViewCell: UITableViewCell {
    
 //MARK: - Properties
    
    private lazy var image = makeImageView()
    private lazy var senderName = makeSenderNameLabel()
    private lazy var message = makeMessageLabel()
    private lazy var time = makeTimeLabel()
    private lazy var notReadMessageIndicator = makeNotReadIndicator()

 //MARK: - Methods

    func configure(model: Message) {
        image.image = model.image
        senderName.text = model.senderName
        message.text = model.message
        contentView.addSubview(image)
        contentView.addSubview(senderName)
        contentView.addSubview(message)
        contentView.addSubview(time)
        contentView.addSubview(notReadMessageIndicator)
        makeConstraints()
    }
}

//MARK: - SetupUI

private extension MessageTableViewCell {
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.layer.cornerRadius = 34
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeNotReadIndicator() -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "NotReadMessageIndicator")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeSenderNameLabel() -> UILabel {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Medium", size: 23)
        view.numberOfLines = 1
        view.adjustsFontSizeToFitWidth = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeMessageLabel() -> UILabel {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat", size: 18)
        view.textColor = .lightGray
        view.numberOfLines = 2
        view.lineBreakMode = .byWordWrapping
        view.sizeToFit()
        view.adjustsFontSizeToFitWidth = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeTimeLabel() -> UILabel {
        let view = UILabel()
        let timeArray = ["9:17", "10:15", "4:43", "15:93"]
        view.text = timeArray.randomElement()
        view.font = UIFont(name: "Montserrat", size: 16)
        view.textColor = .lightGray
        view.numberOfLines = 1
        view.adjustsFontSizeToFitWidth = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            image.heightAnchor.constraint(equalToConstant: 70),
            image.widthAnchor.constraint(equalToConstant: 70),
            
            senderName.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            senderName.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10),
            
            message.topAnchor.constraint(equalTo: senderName.bottomAnchor, constant: 2),
            message.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10),
            message.widthAnchor.constraint(equalToConstant: 260),
            
            time.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            time.rightAnchor.constraint(equalTo: rightAnchor, constant: -13),
            
            notReadMessageIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            notReadMessageIndicator.rightAnchor.constraint(equalTo: rightAnchor, constant: -4),
            notReadMessageIndicator.widthAnchor.constraint(equalToConstant: 38),
            notReadMessageIndicator.heightAnchor.constraint(equalToConstant: 23)
        ])
    }
}

// Расширение для получения индентификатора

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
}
