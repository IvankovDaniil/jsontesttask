//
//  CellView.swift
//  JSONTestTask
//
//  Created by Даниил Иваньков on 22.07.2025.
//

import UIKit

class CellView: UITableViewCell {
    private let avatar = UIImageView()
    private let title = UILabel()
    private let body = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubViews(avatar, title, body)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        avatar.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        body.translatesAutoresizingMaskIntoConstraints = false
        
        avatar.layer.cornerRadius = 25
        avatar.clipsToBounds = true
        
        title.font = .boldSystemFont(ofSize: 18)
        title.numberOfLines = 0
        body.font = .systemFont(ofSize: 16)
        body.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatar.widthAnchor.constraint(equalToConstant: 50),
            avatar.heightAnchor.constraint(equalToConstant: 50),
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 12),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            body.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            body.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            body.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(title: String, body: String, url: URL?) {
        self.title.text = title
        self.body.text = body
        if let url = url {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let self = self else { return }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.avatar.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.avatar.image = UIImage(systemName: "person.crop.circle")
                    }
                }
            }
            .resume()
        } else {
            avatar.image = UIImage(systemName: "person.crop.circle")
        }
    }
}
