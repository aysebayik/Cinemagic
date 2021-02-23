//
//  PopularRow.swift
//  Cinemagic
//
//  Created by Ayşe Bayık on 21.02.2021.
//

import UIKit
import Kingfisher


class PopularRow: UITableViewCell, UICollectionViewDataSource {
    
    @IBOutlet weak var txtCategory: UILabel!
    
    @IBOutlet weak var MovieCollectionView: UICollectionView!
    
    var sourceData : [Result] = []
    
    func configure (with labelName : String, sourceData : [Result] ){
        txtCategory.text = labelName
        self.sourceData = sourceData
        MovieCollectionView.dataSource = self
        MovieCollectionView.reloadData()
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sourceData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomMovieCollectionCell
        
        MovieListController().loadImage(sourceData: sourceData, indexPath: indexPath, cell: cell)
        
        return cell
        
//        let imgArr = MovieListController().loadImage2(sourceData: sourceData)
//        cell.ImageMovie.image = imgArr[indexPath.row].image
//        return cell
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4 
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
