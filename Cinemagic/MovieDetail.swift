//
//  MovieDetail.swift
//  Cinemagic
//
//  Created by Ayşe Bayık on 21.02.2021.
//

import UIKit
import Kingfisher

class MovieDetail: UIViewController {
    
    var item: Result!
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if item.originalTitle.isEmpty != true {
            movieTitle.text = item.originalTitle
            if item.title.isEmpty != true && item.title != item.originalTitle{
                movieTitle.text = "\(item.originalTitle) (\(item.title)) "
            }
        }
        if item.voteAverage != nil {
            movieRate.text = "\(item.voteAverage!)"
        }
        if item.releaseDate.isEmpty != true {
            movieDate.text = item.releaseDate
        }
        if item.overview.isEmpty != true {
            movieOverview.text = item.overview
        }
        if item.posterPath != nil {
            let imagePath = "https://image.tmdb.org/t/p/w500\(item.posterPath!)"
            
            let resource = ImageResource(downloadURL: URL(string: imagePath)!)
            
            movieImage.kf.indicatorType = .activity
            movieImage.kf.setImage(with: resource)
        
            }
        else {
            movieImage.image = UIImage(named: "noMovie")
        }
    }
}
