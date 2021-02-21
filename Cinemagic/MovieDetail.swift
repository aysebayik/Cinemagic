//
//  MovieDetail.swift
//  Cinemagic
//
//  Created by Ayşe Bayık on 21.02.2021.
//

import UIKit

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
        if item.posterPath?.isEmpty != true {
            let imagePath = "https://image.tmdb.org/t/p/w500\(item.posterPath!)"
            movieImage.image = UIImage(data: try! Data(contentsOf: URL(string: imagePath)!))
            
        }
        
        
        
        
        

      
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
