//
//  TopRatedRow.swift
//  Cinemagic
//
//  Created by Ayşe Bayık on 21.02.2021.
//

import UIKit

class TopRatedRow: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var txtCategory2: UILabel!

    @IBOutlet weak var MovieCollectionView2: UICollectionView!
    
    var sourceData : [Result] = []
    
    func configure (with labelName : String, sourceData : [Result] ){
        txtCategory2.text = labelName
        self.sourceData = sourceData
        MovieCollectionView2.dataSource = self
        MovieCollectionView2.delegate = self
        MovieCollectionView2.reloadData()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: \(sourceData[indexPath.row].originalTitle)")
        let item = sourceData[indexPath.row]
        performSegue(withIdentifier: "detail", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "detail" ) {
            let vc = segue.destination as! MovieDetail
            vc.item = sender as? Result
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
