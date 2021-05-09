//
//  DataSource.swift
//  EmojiLibrary
//
//  Created by Roy Park on 5/8/21.
//

import UIKit



class DataSource: NSObject, UICollectionViewDataSource {
//    func emojiCell(didTapWith emoji: String) {
//        let vc = DetailViewController()
//        let nav = UINavigationController(rootViewController: vc)
//        vc.present(nav, animated: true, completion: nil)
//    }
    
    
    let emoji = Emoji.shared
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emoji.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = emoji.sections[section]
        guard let emoji = self.emoji.data[category] else { return 0 }
        return emoji.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: EmojiCell.reuseIdentifier,
                for: indexPath) as? EmojiCell else {
            fatalError("Failed to create EmojiCell")
        }
        
        let category = emoji.sections[indexPath.section]
        cell.emojiLabel.text = self.emoji.data[category]?[indexPath.item] ?? ""
//        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let emojiHeaderView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: EmojiHeaderView.identifier,
                for: indexPath) as? EmojiHeaderView else {
            fatalError("Failed to create EmojiHeaderView")
        }
        
        let category = emoji.sections[indexPath.section]
        emojiHeaderView.textLabel.text = category.rawValue
        
        return emojiHeaderView
    }
}

extension DataSource {
    func addEmoji(_ emoji: String, to category: Emoji.Category) {
        guard var emojiData = self.emoji.data[category] else { return }
        emojiData.append(emoji)
        self.emoji.data.updateValue(emojiData, forKey: category)
        
    }
    
    func deleteEmoji(at indexPath: IndexPath) {
        let category = emoji.sections[indexPath.section]
        guard var emojiData = emoji.data[category] else { return }
        emojiData.remove(at: indexPath.item)
        
        emoji.data.updateValue(emojiData, forKey: category)
    }
    
    func deleteEmoji(at indexPaths: [IndexPath]) {
        for path in indexPaths {
            deleteEmoji(at: path)
        }
    }
}
