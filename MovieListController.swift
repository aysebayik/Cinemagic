//
//  MovieListController.swift
//  Cinemagic
//
//  Created by Ayşe Bayık on 18.02.2021.
//

import UIKit
import Alamofire

class MovieListController: UITableViewController {
    
    
    
    var categories = ["Popular" , "Top Rated" , "Revenue" , "Release Date"]
    var arrPopularMovies: [Result] = []
    var arrTopRatedMovies: [Result] = []
    var arrRevenueMovies: [Result] = []
    var arrReleaseDateMovies: [Result] = []
    var arrMovies: [Result] = []
    var cellScale : CGFloat = 0.6

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var sort_by_data:String
        
        for category in categories {
            switch category {
            case "Popular":
                sort_by_data = "popularity.desc"
            case "Top Rated":
                sort_by_data = "vote_average.desc"
            case "Revenue":
                sort_by_data = "revenue.desc"
            case "Release Date":
                sort_by_data = "release_date.desc"
            default:
                sort_by_data=""
                print("No matching queries.")
            }
        
            let params = [ "api_key":"10e40fc1cc467732a5409989a89be80d", "language":"en-US", "sort_by":sort_by_data, "include_adult":"false" , "include_video":"false" , "page":"1"]
        
            let url = "https://api.themoviedb.org/3/discover/movie"
        
            AF.request(url, method: .get, parameters: params).responseJSON { (res) in
        
                // Standard response for successful HTTP requests control.
                if ( res.response?.statusCode == 200 ) {
        
                    let movie = try? JSONDecoder().decode(Movie.self, from: res.data!)
                    if (movie?.results != nil){
                        switch category {
                        case "Popular":
                            self.arrPopularMovies = movie!.results
                        case "Top Rated":
                            self.arrTopRatedMovies = movie!.results
                        case "Revenue":
                            self.arrRevenueMovies = movie!.results
                        case "Release Date":
                            self.arrReleaseDateMovies = movie!.results
                        default:
                            print("No matching MovieArrays")
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryRow
        
        cell.txtCategory.text = categories[indexPath.row]
        
        if indexPath.row == 0 {
//            print("row1")
            self.arrMovies = self.arrPopularMovies
        }
        else if indexPath.row == 1 {
//            print("row2")
            self.arrMovies = self.arrTopRatedMovies
        }
        else if indexPath.row == 2 {
//            print("row3")
            self.arrMovies = self.arrRevenueMovies
        }
        else if indexPath.row == 3 {
//            print("row4")
            self.arrMovies = self.arrReleaseDateMovies
        }
        
//        arrMovies = [self.arrPopularMovies, self.arrTopRatedMovies, self.arrRevenueMovies, self.arrReleaseDateMovies]
//
        cell.MovieCollectionView.delegate = self
        cell.MovieCollectionView.dataSource = self
        cell.MovieCollectionView.reloadData()
        
        

        return cell
        
        
    }
    
//    func getGenres(){
//
//        let params = [ "api_key":"10e40fc1cc467732a5409989a89be80d", "language":"en-US" ]
//
//        let url = "https://api.themoviedb.org/3/genre/movie/list"
//
//        AF.request(url, method: .get, parameters: params).responseJSON { (res) in
//
//            // Standard response for successful HTTP requests control.
//            if ( res.response?.statusCode == 200 ) {
//
//                let genre = try? JSONDecoder().decode(Genre.self, from: res.data!)
//
//
//                if (genre?.genres != nil){
//                    self.categories = genre?.genres
//                    self.tableView.reloadData()
////                }else {
////                    AF.request(url, method: .get, parameters: params).responseJSON { (res) in
////
////                        // Standard response for successful HTTP requests control.
////                        if ( res.response?.statusCode == 200 ) {
////
////                            let product = try? JSONDecoder().decode(ProductsFalse.self, from: res.data!)
////
////                            let status = product?.products[0].durum
////                            let message = product?.products[0].mesaj
////
////                            if ( status == false ) {
////                                SCLAlertView().showError("Ürün Yok! ", subTitle: "\(message!)", closeButtonTitle: "Tamam")
////                            }
////                        }
////                    }
//                }
//            }
//        }
//    }
    
    
    
}

extension MovieListController : UICollectionViewDataSource  {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CustomMovieCollectionCell
    

        
        
        let firstPath = "https://image.tmdb.org/t/p/w500"
        if arrMovies.isEmpty == false{
            if self.arrMovies[indexPath.row].posterPath?.isEmpty == false{
                let imagePath = self.arrMovies[indexPath.row].posterPath
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
    
    

}

extension MovieListController : UICollectionViewDelegateFlowLayout {


//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

////        let flowLayout: UICollectionViewFlowLayout = {
////            let layout = UICollectionViewFlowLayout()
////            layout.minimumInteritemSpacing = 5
////            layout.minimumLineSpacing = 5
////            layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
////            return layout
////        }()
////
////        let width = collectionView.bounds.width
////        let numberOfItemsPerRow: CGFloat = 3
////        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
////        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
////        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
////        return CGSize(width: itemDimension, height: itemDimension)
////
////        ****
//
//
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
//
////        ***
//
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
//        return 0
//    }

}

