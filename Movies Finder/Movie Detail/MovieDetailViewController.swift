//
//  MovieDetailViewController.swift
//  Movies Finder
//
//  Created by Noel Conde Algarra on 27/11/21.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var poster: UIImageView! {
        didSet {
            poster.sd_setImage(with: URL(string: movie.poster),
                               placeholderImage: UIImage(named: "posterPlaceholder"))
            poster.isUserInteractionEnabled = true
            poster.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                               action: #selector(enlargePoster)))
        }
    }
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel! {
        didSet {
            labelReleaseDate.isUserInteractionEnabled = true
            labelReleaseDate.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                         action: #selector(copyRelease)))
        }
    }
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
    @IBOutlet weak var labelPlot: UILabel!
    @IBOutlet weak var labelWeb: UILabel! {
        didSet {
            labelWeb.textColor = UIColor.systemBlue
            labelWeb.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(openWeb)))
        }
    }
    
    private var movie: Movie
    
    init(_ movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = movie.title
        labelReleaseDate.text = movie.released
        labelDuration.text = movie.runtime
        labelGenre.text = movie.genre
        labelPlot.text = movie.plot
        labelWeb.text = movie.website
        
        
    }
    
    // MARK: Selectors
    
    @objc func copyRelease() {
        UIPasteboard.general.string = labelReleaseDate.text
    }
    
    @objc func enlargePoster() {
//        DispatchQueue.main.async {
            let vc = PosterViewController(self.movie.poster)
            self.providesPresentationContextTransitionStyle = true
            self.definesPresentationContext = true
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
//        }
    }
    
    @objc func openWeb() {
        if let url = URL(string: movie.website.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
