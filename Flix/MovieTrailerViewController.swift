//
//  MovieTrailerViewController.swift
//  Flix
//
//  Created by Leonardo Valdivia on 4/16/21.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {

    @IBOutlet weak var trailerView: WKWebView!
    
    var trailerKey: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string: "https://www.youtube.com/watch?v=\(trailerKey)")
        let videoRequest = URLRequest(url: url!)
        trailerView.load(videoRequest)
        
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
