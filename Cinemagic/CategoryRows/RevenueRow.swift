//
//  RevenueRow.swift
//  Cinemagic
//
//  Created by Ayşe Bayık on 21.02.2021.
//

import UIKit

class RevenueRow: UITableViewCell , UICollectionViewDataSource{
    
    @IBOutlet weak var txtCategory3: UILabel!

    @IBOutlet weak var MovieCollectionView3: UICollectionView!
    
    var sourceData : [Result] = []
    
    
    func configure (with labelName : String, sourceData : [Result] ){
        txtCategory3.text = labelName
        self.sourceData = sourceData
        MovieCollectionView3.dataSource = self
        MovieCollectionView3.reloadData()
    }
    
    func makeSegue()-> [Result]{
        return sourceData
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
        return 20
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
