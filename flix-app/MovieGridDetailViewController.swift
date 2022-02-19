//
//  MovieGridDetailViewController.swift
//  flix-app
//
//  Created by Ermain Paul on 2/18/22.
//

import UIKit
import AlamofireImage

class MovieGridDetailViewController: UIViewController {
	@IBOutlet weak var posterView: UIImageView!
	@IBOutlet weak var iconView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var synopsisLabel: UILabel!
	
	var movie: [String: Any]!

    override func viewDidLoad() {
		let baseURL = "https://image.tmdb.org/t/p/w185"
        super.viewDidLoad()
		print(movie["title"] ?? "None")
        // Do any additional setup after loading the view.
		titleLabel.text = movie["title"] as? String
		synopsisLabel.text = movie["overview"] as? String
		synopsisLabel.sizeToFit()
		
		// Set up the image path
		let posterPath = movie["poster_path"] as! String
		let posterURL = URL(string: baseURL + posterPath)
		iconView.af.setImage(withURL: posterURL!)
		
		//
		let backdropImagePath = movie["poster_path"] as! String
		let backdropImageURL = URL(string: "https://image.tmdb.org/t/p/w780" + backdropImagePath)
		posterView.af.setImage(withURL: backdropImageURL!)
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
