//
//  PopularRow.swift
//  Cinemagic
//
//  Created by Ayşe Bayık on 21.02.2021.
//

import UIKit

class PopularRow: UITableViewCell, UICollectionViewDataSource {
    
    @IBOutlet weak var txtCategory: UILabel!

    @IBOutlet weak var MovieCollectionView: UICollectionView!
    
    var sourceData : [Result] = []
    
    
    
    func configure (with labelName : String, sourceData : [Result] ){
        txtCategory.text = labelName
        self.sourceData = sourceData
        MovieCollectionView.dataSource = self
//        MovieCollectionView.delegate = self
        MovieCollectionView.reloadData()
    }
    
    func makeSegue()-> [Result]{
        return sourceData
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sourceData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomMovieCollectionCell
        
        
        let firstPath = "https://image.tmdb.org/t/p/w500"
        if self.sourceData.isEmpty == false{
            if self.sourceData[indexPath.row].posterPath?.isEmpty == false{
                let imagePath = self.sourceData[indexPath.row].posterPath
                let fullPath = firstPath + imagePath!
                let url = URL(string: fullPath)
                let data = try! Data(contentsOf: url!)
                cell.ImageMovie.image = UIImage(data: data)
            }
            else {
                cell.ImageMovie.image = UIImage(named: "noMovie")
            }
        }
        return cell
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
