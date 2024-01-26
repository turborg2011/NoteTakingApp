//
//  NoteCell.swift
//  NoteTakingApp
//
//  Created by Хайдар Даукаев on 27.01.2024.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    weak var titleLabel: UILabel!
    
    private lazy var delButton = {
        let button = UIButton()
        
        button.setTitle("Del", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(self.touchDelButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func touchDelButton() {
        print("touch del btn")
    }
    
    private func configure() {
        
        delButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            delButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            delButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            delButton.widthAnchor.constraint(equalToConstant: 70),
            delButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            titleLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
        ])
        
        self.titleLabel = titleLabel
        
//        self.backgroundColor = .lightGray
        titleLabel.textAlignment = .center
        titleLabel.text = "LOOOOL"
        
        self.addSubview(delButton)
        self.configure()
        
        let colors: [CGColor] = [
            UIColor.systemBlue.cgColor,
            UIColor.systemRed.cgColor,
            UIColor.systemGreen.cgColor,
            UIColor.systemYellow.cgColor,
            UIColor.systemPink.cgColor,
        ]
        
        self.layer.borderColor = colors.randomElement() ?? UIColor.systemYellow.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        
        self.isUserInteractionEnabled = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title: String?) {
        guard let title = title else {
            titleLabel.text = "Новая заметка"
            return
        }
        
        titleLabel.text = title
    }
}
