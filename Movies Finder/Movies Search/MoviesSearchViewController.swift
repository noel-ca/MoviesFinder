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
        searchMovies.becomeFirstResponder()
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
    
    func getMovie(id: String) {
        apiEngine.getMovieInfo(imdbID: id) { movieInfo, response, error in
            if let movieInfo = movieInfo, error == nil {
                DispatchQueue.main.async {
                    let vc = MovieDetailViewController(movieInfo)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(onViewController: self,
                                   title: "Abrir película",
                                   mssg: "No se pudieron recuperar los datos de la película. Compruebe su conexión a internet.")
                }
            }
        }
    }
    
    func showInfo() {
        movies.removeAll()
        labelInfo.isHidden = false
        tableMovies.isHidden = true
    }
    
    func hideInfo() {
        labelInfo.isHidden = true
        tableMovies.isHidden = false
    }
    
    func removeSearch() {
        movies.removeAll()
        showInitInfo()
    }
    
    func showInitInfo() {
        labelInfo.text = "Busque una película por su título"
        showInfo()
    }
    
    func showConnectionProblem() {
        labelInfo.text = "Problema de red. Compruebe su conexión a internet."
        showInfo()
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
        cellMovie.poster.sd_setImage(with: URL(string: selectedmovie.poster),
                                     placeholderImage: UIImage(named: "posterPlaceholder"))
        cellMovie.title.text = selectedmovie.title
        cellMovie.year.text = selectedmovie.year
        
        return cellMovie
    }
}

extension MoviesSearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedmovie = movies[indexPath.row]
        getMovie(id: selectedmovie.imdbID)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
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
