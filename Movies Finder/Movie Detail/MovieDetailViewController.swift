//
//  MovieDetailViewController.swift
//  Movies Finder
//
//  Created by Noel Conde Algarra on 27/11/21.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabelCopyable!
    @IBOutlet weak var labelReleaseDate: UILabelCopyable!
    @IBOutlet weak var labelDuration: UILabelCopyable!
    @IBOutlet weak var labelGenre: UILabelCopyable!
    @IBOutlet weak var labelPlot: UILabelCopyable!
    @IBOutlet weak var labelWeb: UILabelCopyable! {
        didSet {
            labelWeb.textColor = UIColor.systemBlue
            labelWeb.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                 action: #selector(openWeb)))
        }
    }
    @IBOutlet weak var poster: UIImageView! {
        didSet {
            poster.sd_setImage(with: URL(string: movie.poster),
                               placeholderImage: UIImage(named: "posterPlaceholder"))
            poster.isUserInteractionEnabled = true
            poster.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                               action: #selector(enlargePoster)))
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
    
    @objc func enlargePoster() {
        let vc = PosterViewController(self.movie.poster)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func openWeb() {
        if let url = URL(string: movie.website.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
