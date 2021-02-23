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
    
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieRate: UILabel!
    @IBOutlet var movieDate: UILabel!
    @IBOutlet var movieOverview: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if item.originalTitle.isEmpty != true {
            movieTitle.text = item.originalTitle
            if item.title.isEmpty != true && item.title != item.originalTitle{
                movieTitle.text = "\(item.originalTitle) (\(item.title)) "
            }
        }
        if item.voteAverage != nil {
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "star")
            let finalString = NSMutableAttributedString()
            let attachmentString = NSAttributedString(attachment: attachment)
            let myString = NSMutableAttributedString(string: "\(item.voteAverage!) ")
            finalString.append(attachmentString)
            finalString.append(myString)
            movieRate.attributedText = finalString
        }
        if item.releaseDate.isEmpty != true {
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: "calendar")
            let attachmentString = NSAttributedString(attachment: attachment)
            let myString = NSMutableAttributedString(string: item.releaseDate )
            myString.append(attachmentString)
            movieDate.attributedText = myString
            
        }
        if item?.overview == nil ||  item?.overview == ""{
            movieOverview.text = "There is no overview."
        }else{
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

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
//        if device has been rotated to landscape orientation current page will look like
        if UIDevice.current.orientation.isLandscape{
            print("landscape")

            movieImage.frame = CGRect(x: 482, y: 44, width: 392, height: 349)
            movieTitle.frame = CGRect(x: 60, y: 63, width: 389, height: 40)
            movieRate.frame = CGRect(x: 60, y: 111, width: 114, height: 29)
            movieDate.frame = CGRect(x: 240, y: 111, width: 209, height: 29)
            movieOverview.frame = CGRect(x: 60, y: 148, width: 389, height: 245)
            
        }
//        if device has been rotated to portrair orientation current page will look like 
        if UIDevice.current.orientation.isPortrait{
            print("portrait")
            
            movieImage.frame = CGRect(x: 11, y: 103, width: 392, height: 367)
            movieTitle.frame = CGRect(x: 11, y: 478, width: 392, height: 40)
            movieRate.frame = CGRect(x: 10, y: 523, width: 176, height: 29)
            movieDate.frame = CGRect(x: 250, y: 523, width: 153, height: 29)
            movieOverview.frame = CGRect(x: 10, y: 558, width: 393, height: 304)

        
        }
    }
}
