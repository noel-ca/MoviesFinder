//
//  MoviesSearchViewController.swift
//  Movies Finder
//
//  Created by Noel Conde Algarra on 27/11/21.
//

import UIKit

class MoviesSearchViewController: UIViewController {

    @IBOutlet weak var searchMovies: UISearchBar!
    @IBOutlet weak var tableMovies: UITableView!
    @IBOutlet weak var labelInfo: UILabel!
    
    private let apiEngine = ApiEngine.shared
    private var movies = [SearchMovie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableMovies.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableMovies.register(UINib(nibName: "MovieSearchTableViewCell", bundle: nil),
                             forCellReuseIdentifier: "MovieSearchTableViewCell")
        tableMovies.delegate = self
        tableMovies.dataSource = self
        tableMovies.rowHeight = UITableView.automaticDimension
        searchMovies.delegate = self
        showInitInfo()
    }

    // MARK: Functions
    
    func searchMovies(title: String) {
        apiEngine.searchMovies(title) { moviesResult, response, error in
            
            if let moviesResult = moviesResult, error == nil {
                self.movies = moviesResult
            } else if let httpResponse = response as? HTTPURLResponse {
                let code = httpResponse.statusCode
                DispatchQueue.main.async {
                    switch code {
                    case 200:
                        self.showInfo()
                        self.labelInfo.text = "Demasiados resultados. Concrete mejor el título de la película."
                    default:
                        self.showConnectionProblem()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showConnectionProblem()
                }
            }
        }
    }
    
    func showInfo() {
        labelInfo.isHidden = false
        tableMovies.isHidden = true
    }
    
    func hideInfo() {
        labelInfo.isHidden = true
        tableMovies.isHidden = false
    }
    
    func showInitInfo() {
        labelInfo.text = "Busque una película por su título"
        showInfo()
    }
    
    func showConnectionProblem() {
        labelInfo.text = "Problema de red. Compruebe su conexión a internet."
        showInfo()
    }
    
    func removeSearch() {
        movies.removeAll()
        showInitInfo()
    }
}

extension MoviesSearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellMovie = tableView.dequeueReusableCell(withIdentifier: "MovieSearchTableViewCell", for: indexPath) as! MovieSearchTableViewCell
        
        let selectedmovie = movies[indexPath.row]
        cellMovie.title.text = selectedmovie.title
        cellMovie.year.text = selectedmovie.year
        
        return cellMovie
    }
}

extension MoviesSearchViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedmovie = movies[indexPath.row]

  }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
 }
}

extension MoviesSearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchMovies(title: searchText)
            hideInfo()
        } else {
            removeSearch()
        }
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        removeSearch()
    }
}
