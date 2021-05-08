//
//  ViewController.swift
//  collectionView
//
//  Created by Roy Park on 5/8/21.
//

import UIKit

class ViewController: UIViewController {
    enum Section {
        case main
    }
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    let colors: [UIColor] = [.red, .blue, .brown, .clear, .cyan, .systemGreen, .link]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
        let layout = configureLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.backgroundColor = .systemBackground
//        collectionView.collectionViewLayout = configureLayout()
        collectionView.register(
            CustomCollectionViewCell.self,
            forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        configureDataSource()

        view.addSubview(collectionView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.20),
            heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.2))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDataSource() {
        
        guard let _collectionView = self.collectionView else { return }
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(
            collectionView: _collectionView,
            cellProvider: { collectionView, indexPath, number in
                guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: CustomCollectionViewCell.identifier,
                        for: indexPath) as? CustomCollectionViewCell else {
                    fatalError()
                }
                
//                cell.configure(with: number)
                cell.label.text = number.description
                cell.backgroundColor = self.colors.randomElement()
                return cell
            })
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(Array(1...100), toSection: .main)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
}

//extension ViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: CustomCollectionViewCell.identifier,
//                for: indexPath) as? CustomCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//
//        return cell
//    }
//}
