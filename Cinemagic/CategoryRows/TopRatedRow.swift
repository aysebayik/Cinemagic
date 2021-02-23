//
//  TopRatedRow.swift
//  Cinemagic
//
//  Created by Ayşe Bayık on 21.02.2021.
//

import UIKit

class TopRatedRow: UITableViewCell, UICollectionViewDataSource {
    
    @IBOutlet weak var txtCategory2: UILabel!

    @IBOutlet weak var MovieCollectionView2: UICollectionView!
    
    var sourceData : [Result] = []
    
    func configure (with labelName : String, sourceData : [Result] ){
        txtCategory2.text = labelName
        self.sourceData = sourceData
        MovieCollectionView2.dataSource = self
        MovieCollectionView2.reloadData()
        
        
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
