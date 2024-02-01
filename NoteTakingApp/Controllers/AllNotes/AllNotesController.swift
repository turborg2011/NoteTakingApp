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
    
    @objc func addButtonTapped() {
        let detailVC = NoteDetailController()
        detailVC.isFav = false
        navigationController?.pushViewController(detailVC, animated: true)
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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItem = addButton
            
        notesCollectionView.didSelectNote = { [weak self] id, isFav in
            let detailVC = NoteDetailController()
            detailVC.noteID = id
            detailVC.isFav = isFav
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        notesCollectionView.tapDeleteHandler = { [weak self] id in
            DataProvider.shared.deleteNote(with: id)
            self?.updateData()
        }
        
        navigationController?.tabBarItem.title = Resources.Strings.TabBar.allNotes
        title = Resources.Strings.NavBar.allNotes
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
    }
}
