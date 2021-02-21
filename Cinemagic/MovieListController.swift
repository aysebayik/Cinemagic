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
    var arrMovies: [[Result]] = [[]]
    var cellScale : CGFloat = 0.6
    var section : Int = 0

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
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath)
        
        arrMovies = [arrPopularMovies,arrTopRatedMovies,arrRevenueMovies,arrReleaseDateMovies]
        
        
        if indexPath.section == 0 {
            if let  popCell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as? PopularRow {
                
                popCell.configure(with: categories[indexPath.section],sourceData: arrPopularMovies)
                popCell.MovieCollectionView.delegate = self
                popCell.MovieCollectionView.reloadData()
                
                cell = popCell
            }
        }else if indexPath.section == 1 {
            if let  topCell = tableView.dequeueReusableCell(withIdentifier: "topRatedCell", for: indexPath) as? TopRatedRow {
                
                topCell.configure(with: categories[indexPath.section],sourceData: arrTopRatedMovies)
                
                topCell.MovieCollectionView2.delegate = self
                topCell.MovieCollectionView2.reloadData()
                
                cell = topCell
            }
        }else if indexPath.section == 2 {
            if let  revCell = tableView.dequeueReusableCell(withIdentifier: "revenueCell", for: indexPath) as? RevenueRow {
                
                revCell.configure(with: categories[indexPath.section],sourceData: arrRevenueMovies)
                
                revCell.MovieCollectionView3.delegate = self
                revCell.MovieCollectionView3.reloadData()
                
                cell = revCell
            }
        }else if indexPath.section == 3 {
            if let  releaseCell = tableView.dequeueReusableCell(withIdentifier: "releaseDateCell", for: indexPath) as? ReleaseDateRow {
                
                releaseCell.configure(with: categories[indexPath.section],sourceData: arrReleaseDateMovies)
                
                releaseCell.MovieCollectionView4.delegate = self
                releaseCell.MovieCollectionView4.reloadData()
                
                cell = releaseCell
            }
        }
        

        return cell
        
        
    }
    
    

   
    
//    public func callSegue (item : Result!) {
//        print("callSegue called")
//        performSegue(withIdentifier: "detail", sender: item)
//    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.section = indexPath.section
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if ( segue.identifier == "detail" ) {
            
            let vc = segue.destination as! MovieDetail
            vc.item = sender as? Result
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.item)
//    }
    
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


extension MovieListController : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 3
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: \(arrMovies[self.section][indexPath.row].originalTitle)")
        let item = arrMovies[self.section][indexPath.row]
        performSegue(withIdentifier: "detail", sender: item)
    }
//

//
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
