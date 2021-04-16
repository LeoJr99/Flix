//
//  MoviesDetailViewController.swift
//  Flix
//
//  Created by Leonardo Valdivia on 4/14/21.
//

import UIKit
import Alamofire

class MoviesDetailViewController: UIViewController {
    
    var movie: [String: Any]!
    var movieInfo: [String: Any]! 

    @IBOutlet weak var backdropView: UIImageView! {
        didSet {
            backdropView.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!
        posterView.af_setImage(withURL: posterUrl)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
        backdropView.af_setImage(withURL: backdropUrl)
                
        
        let movieID = movie["id"] as! Int

        let url = URL(string: "https://api.themoviedb.org/3/movie/\(String(describing: movieID))/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            let movieData = dataDictionary["results"] as! [[String:Any]]
            self.movieInfo = movieData[0]
            
           }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let trailerViewController = segue.destination as! MovieTrailerViewController
        trailerViewController.trailerKey = movieInfo["key"] as! String

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
