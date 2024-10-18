import UIKit

final class MovieListViewController: UIViewController {
    
    let movieService = MovieService()
    var movies: [MovieSummary] = []
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Trending Movies"
        setupTableView()
        fetchMoviess()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    private func fetchMoviess() {
        movieService.fetchTrendingMovies { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.movies = success.movieResults
                    self?.tableView.reloadData()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    print(failure)
                }
            }
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource  {
    // MARK: - UITableView DataSource and Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        
        let title = movie.title
        let year = "\(movie.year ?? "-")"
        cell.configure(with: title, year: year)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let detailVC = MovieDetailViewController(movieId: movie.imdbId ?? "tt0000000")
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
