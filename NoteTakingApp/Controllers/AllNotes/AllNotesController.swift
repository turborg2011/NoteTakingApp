//
//  allNotesController.swift
//  NoteTakingApp
//
//  Created by Хайдар Даукаев on 26.01.2024.
//

import UIKit

final class AllNotesController: BaseController {
    
    private var notesCollectionView: NotesCollectionView!
    
    private func convertToNoteModel(note: Note) -> NoteModel? {
        guard let id = note.id, let text = note.text else { return nil }
        
        return NoteModel(ID: id, noteText: text, isFav: note.isFav)
    }
    
    override func viewDidLoad() {
        
        let layout = UICollectionViewFlowLayout()
        notesCollectionView = NotesCollectionView(frame: view.frame, collectionViewLayout: layout)
        notesCollectionView.isOpaque = false
        notesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 85, right: 0)
        
        extendedLayoutIncludesOpaqueBars = true
        super.viewDidLoad()
        
        updateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateData()
    }
    
    private func updateData() {
        do {
            let notes = DataProvider.shared.fetchNotes()
            let resNotes = notes.map { note in
                convertToNoteModel(note: note)
            }
            var notesData: [NoteModel] = []
            resNotes.forEach { note in
                if let note = note {
                    notesData.append(note)
                }
            }
            
            notesCollectionView.setData(data: notesData)
        }
    }
}

extension AllNotesController {
    
    override func addViews() {
        super.addViews()
        view.addSubview(notesCollectionView)
    }
    
    override func layoutViews() {
        super.layoutViews()
        
        notesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            notesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            notesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            notesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func configure() {
        super.configure()
        
        notesCollectionView.didSelectNote = { [weak self] id in
            let detailVC = NoteDetailController()
            detailVC.noteID = id
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        navigationController?.tabBarItem.title = Resources.Strings.TabBar.allNotes
        title = Resources.Strings.NavBar.allNotes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}
