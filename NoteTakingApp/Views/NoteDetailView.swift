//
//  NoteDetailView.swift
//  NoteTakingApp
//
//  Created by Хайдар Даукаев on 01.02.2024.
//

import UIKit

final class NoteDetailView: UIView {
    
    private lazy var mainText: UITextView = {
        let textView = UITextView()
        textView.text = "Ваша заметка"
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = true
        textView.isScrollEnabled = true
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setData(noteModel: NoteModel) {
        mainText.text = noteModel.noteText
    }
    
    public func getData() -> String {
        return mainText.text
    }
    
    private func layoutViews() {
        self.addSubview(mainText)
        
        mainText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            mainText.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            mainText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainText.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
}



