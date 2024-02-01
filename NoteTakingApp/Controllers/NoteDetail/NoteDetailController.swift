//
//  NoteDetailController.swift
//  NoteTakingApp
//
//  Created by Хайдар Даукаев on 01.02.2024.
//

import UIKit

final class NoteDetailController: BaseController {
    
    var noteID: UUID?
    var isFav: Bool?
    private let noteView = NoteDetailView(frame: .zero)
    private var bottomConstrWithKB: NSLayoutConstraint?
    private var bottomConstrWithoutKB: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        extendedLayoutIncludesOpaqueBars = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        saveNote(noteText: noteView.getData())
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {

            bottomConstrWithKB = noteView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -keyboardSize.height)
            bottomConstrWithoutKB?.isActive = false
            bottomConstrWithKB?.isActive = true
            view.setNeedsUpdateConstraints()
            
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let bottomConstrWithoutKB = bottomConstrWithoutKB, let bottomConstrWithKB = bottomConstrWithKB {
            bottomConstrWithKB.isActive = false
            bottomConstrWithoutKB.isActive = true
            view.setNeedsUpdateConstraints()
        }
    }
    
    private func getNoteData() -> NoteModel? {
        if let noteID = noteID {
            let note = DataProvider.shared.fetchNote(with: noteID)
            if let id = note?.id, let text = note?.text, let isFav = note?.isFav {
                return NoteModel(ID: id, noteText: text, isFav: isFav)
            }
        }
        
        return nil
    }
    
    private func saveNote(noteText: String) {
        if let noteID = noteID, let _ = isFav, let noteCoreData = DataProvider.shared.fetchNote(with: noteID) {
            DataProvider.shared.updateNote(with: noteID, newText: noteText, isFav: noteCoreData.isFav)
        } else {
            let id = UUID()
            DataProvider.shared.createNote(id, text: noteText, isFav: false)
        }
    }
}

extension NoteDetailController {
    
    override func addViews() {
        super.addViews()
        
        view.addSubview(noteView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        noteView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomConstrWithKB = noteView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(tabBarController?.tabBar.frame.size.height ?? 90))
        
        NSLayoutConstraint.activate([
            noteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            noteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            noteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        bottomConstrWithKB?.isActive = true
        view.setNeedsUpdateConstraints()
        
    }
    
    override func configure() {
        super.configure()
          
        if let noteModel = getNoteData() {
            noteView.setData(noteModel: noteModel)
        }
        
        navigationItem.largeTitleDisplayMode = .never
        
    }
}
