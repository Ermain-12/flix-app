//
//  MovieGridViewController.swift
//  flix-app
//
//  Created by Ermain Paul on 2/17/22.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController {
	
	@IBOutlet weak var collectionView: UICollectionView!
	var movies = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.delegate = self
		collectionView.dataSource = self
		
		/*
		let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
		layout.minimumLineSpacing = 4
		layout.minimumInteritemSpacing = 4
		let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
		layout.itemSize = CGSize(width: width, height: width * 3 / 2)
		*/
		
        // Do any additional setup after loading the view.
		let urlString = URL(string: "https://api.themoviedb.org/3/movie/634649/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
		let urlRequest = URLRequest(url: urlString, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 15)
		let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
		let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
			if let err = error {
				print(err.localizedDescription)
			} else if let data = data {
				let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
				
				self.movies = dataDictionary["results"] as! [[String:Any]]
				self.collectionView.reloadData()
				print(self.movies)
			}
		}
		dataTask.resume()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let cell = sender as! UICollectionViewCell
		let indexPath = collectionView.indexPath(for: cell)!
		let movie = movies[indexPath.item]
		
		// Prepare the segue
		let movieGridDetailView = segue.destination as! MovieGridDetailViewController
		movieGridDetailView.movie = movie
		collectionView.deselectItem(at: indexPath, animated: true)
    }
    

}

extension MovieGridViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		movies.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
		let movie = movies[indexPath.item]
	
		let baseURL = "https://image.tmdb.org/t/p/w185"
		let posterPath = movie["poster_path"] as! String
		let posterURL = URL(string: baseURL + posterPath)
		cell.posterView.af.setImage(withURL: posterURL!)
		cell.layoutIfNeeded()
		
		return cell
	}
}
