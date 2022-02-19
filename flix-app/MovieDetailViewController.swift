//
//  MovieDetailViewController.swift
//  flix-app
//
//  Created by Ermain Paul on 2/17/22.
//

import UIKit
import AlamofireImage

class MovieDetailViewController: UIViewController {
	
	@IBOutlet weak var backdropImageView: UIImageView!
	@IBOutlet weak var posterView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var synopsisView: UILabel!
	
	
	var movie: [String: Any]!

    override func viewDidLoad() {
        super.viewDidLoad()
		let baseURL = "https://image.tmdb.org/t/p/w185"

        // Do any additional setup after loading the view.
		print(movie["title"] ?? "None")
		titleLabel.text = movie["title"] as? String
		synopsisView.text = movie["overview"] as? String
		synopsisView.sizeToFit()
		
		// Set the poster image view
		let posterURL = movie["poster_path"] as! String
		let posterPath = URL(string: baseURL + posterURL)
		posterView.af.setImage(withURL: posterPath!)
		
		// Set the backdrop image view
		let backdropImageURL = movie["poster_path"] as! String
		let backdropImagePath = URL(string: "https://image.tmdb.org/t/p/w780" + backdropImageURL)
		backdropImageView.af.setImage(withURL: backdropImagePath!)
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
