//
//  CategoryRow.swift
//  Cinemagic
//
//  Created by Ayşe Bayık on 18.02.2021.
//

import UIKit

class CategoryRow: UITableViewCell {
    
    @IBOutlet weak var txtCategory: UILabel!

    @IBOutlet weak var MovieCollectionView: UICollectionView!
    
//    @IBOutlet weak var MovieCollectionView2: UICollectionView!
    
    

    static func createLayout() -> UICollectionViewCompositionalLayout{
//        item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//        ***
        let verticalStackItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)))
        
        verticalStackItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let VerticalStackGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)), subitem: verticalStackItem, count: 2)
//        ***
        
        let tripleItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(100)))
        
        tripleItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let tripleHorizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0)), subitem: tripleItem, count: 3)
        
        
        
//        group
        
          
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/3)), subitems: [item, VerticalStackGroup])
        
        
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(3/5)), subitems: [
            horizontalGroup,
            tripleHorizontalGroup
            
        ])
        
//        sections
        
        let section = NSCollectionLayoutSection(group: verticalGroup)
        
//        return
        
        return UICollectionViewCompositionalLayout(section: section)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        MovieCollectionView.collectionViewLayout = CategoryRow.createLayout()
//        self.MovieCollectionView.isPagingEnabled = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


