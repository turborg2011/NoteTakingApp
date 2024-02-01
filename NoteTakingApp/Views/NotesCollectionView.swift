//
//  NotesCollectionView.swift
//  NoteTakingApp
//
//  Created by Хайдар Даукаев on 27.01.2024.
//

import UIKit
import Foundation

final class NotesCollectionView: UICollectionView {
    
    private var notes: [NoteModel] = []
    
    public var didSelectNote: ((_ noteID: UUID, _ isFav: Bool) -> ())?
    public var tapDeleteHandler: ((_ noteID: UUID) -> ())?
    
    public func setData(data: [NoteModel]) {
        self.notes = data
        self.reloadData()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        let customLayout = UICollectionViewFlowLayout()
        customLayout.scrollDirection = .vertical
        customLayout.minimumInteritemSpacing = 5
        customLayout.minimumLineSpacing = 10
        customLayout.sectionInset = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9)
        
        super.init(frame: frame, collectionViewLayout: customLayout)
        
        self.delegate = self
        self.dataSource = self
        self.isUserInteractionEnabled = true
        self.register(NoteCell.self, forCellWithReuseIdentifier: "\(NoteCell.self)")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NotesCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select note id \(notes[indexPath.item].ID.uuidString)")
        didSelectNote?(notes[indexPath.item].ID, notes[indexPath.item].isFav)
    }
}

extension NotesCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(NoteCell.self)", for: indexPath) as! NoteCell
        
        cell.setTitle(title: notes[indexPath.item].noteText)
        cell.delegate = self
        
        return cell
    }
}

extension NotesCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
//            print("\(collectionView.bounds.size.width)")
//            print("\(collectionView.bounds.size.width / 2)")
//            print("\(collectionView.bounds.size.width / 2 - 12)")
            
            
            return CGSize.init(
                width: Int(collectionView.bounds.size.width) / 2 - 14,
                height: 240
            )
            
        }
}

extension NotesCollectionView: NoteCellDelegate {
    func addToFavsTapped(_ cell: NoteCell) {
        print("add to favs tapped")
    }
    
    func delTapped(_ cell: NoteCell) {
        if let indexPath = self.indexPath(for: cell) {
            tapDeleteHandler?(notes[indexPath.item].ID)
        }
    }
}
