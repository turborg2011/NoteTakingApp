//
//  NoteCell.swift
//  NoteTakingApp
//
//  Created by Хайдар Даукаев on 27.01.2024.
//

import UIKit

protocol NoteCellDelegate {
    func addToFavsTapped(_ cell: NoteCell)
    func delTapped(_ cell: NoteCell)
}

class NoteCell: UICollectionViewCell {
    
    weak var textView: UITextView!
    var delegate: NoteCellDelegate?
    
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
        delegate?.delTapped(self)
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
        
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: 10
            ),
            textView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,constant: -50
            ),
            textView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 10
            ),
            textView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -10
            ),
        ])
        
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.font = .systemFont(ofSize: 20)
        
        self.textView = textView
        
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
            textView.text = "Новая заметка"
            return
        }
        
        textView.text = title
    }
}
