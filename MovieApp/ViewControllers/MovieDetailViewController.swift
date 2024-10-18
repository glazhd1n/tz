import UIKit

final class MovieDetailViewController: UIViewController {

    let movieService = MovieService()
    var movieId: String
    var movie: MovieDetail?

    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let yearLabel = UILabel()
    let imdbRatingLabel = UILabel()
    let runtimeLabel = UILabel()
    
    let genresScrollView = UIScrollView()
    let starsScrollView = UIScrollView()
    let countriesScrollView = UIScrollView()

    init(movieId: String) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        fetchMovieDetails()
    }

    func setupViews() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0

        imdbRatingLabel.font = UIFont.systemFont(ofSize: 18)
        runtimeLabel.font = UIFont.systemFont(ofSize: 18)
        yearLabel.font = UIFont.systemFont(ofSize: 18)

        genresScrollView.showsHorizontalScrollIndicator = false
        starsScrollView.showsHorizontalScrollIndicator = false
        countriesScrollView.showsHorizontalScrollIndicator = false

        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(yearLabel)
        view.addSubview(imdbRatingLabel)
        view.addSubview(runtimeLabel)
        view.addSubview(genresScrollView)
        view.addSubview(starsScrollView)
        view.addSubview(countriesScrollView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        imdbRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        runtimeLabel.translatesAutoresizingMaskIntoConstraints = false
        genresScrollView.translatesAutoresizingMaskIntoConstraints = false
        starsScrollView.translatesAutoresizingMaskIntoConstraints = false
        countriesScrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            yearLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            yearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            imdbRatingLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 20),
            imdbRatingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            runtimeLabel.topAnchor.constraint(equalTo: imdbRatingLabel.bottomAnchor, constant: 20),
            runtimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            genresScrollView.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: 20),
            genresScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genresScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            genresScrollView.heightAnchor.constraint(equalToConstant: 40),
            
            starsScrollView.topAnchor.constraint(equalTo: genresScrollView.bottomAnchor, constant: 20),
            starsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            starsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            starsScrollView.heightAnchor.constraint(equalToConstant: 40),

            countriesScrollView.topAnchor.constraint(equalTo: starsScrollView.bottomAnchor, constant: 20),
            countriesScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countriesScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            countriesScrollView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    func fetchMovieDetails() {
        movieService.fetchMovieDetails(by: movieId) { [weak self] result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self?.movie = movie
                    self?.updateUI()
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    print(failure.localizedDescription)
                }
            }
        }
    }

    func updateUI() {
        titleLabel.text = "Title: \n\(movie?.title ?? "Unknown Movie")"
        descriptionLabel.text = "Description: \n\(movie?.description ?? "Unknown Movie")"
        yearLabel.text = "Year: \(movie?.year ?? "N/A")"
        imdbRatingLabel.text = "IMDb: \(movie?.imdbRating ?? "N/A") / 10"
        runtimeLabel.text = "Runtime: \(movie?.runtime ?? 0) mins"
        
        // Update genres
        updateScrollView(genresScrollView, withItems: movie?.genres ?? [], backgroundColor: .orange)

        // Update stars
        updateScrollView(starsScrollView, withItems: movie?.stars ?? [], backgroundColor: .systemBlue)
        
        // Update countries
        updateScrollView(countriesScrollView, withItems: movie?.countries ?? [], backgroundColor: .systemPink)
    }

    private func updateScrollView(_ scrollView: UIScrollView, withItems items: [String], backgroundColor: UIColor) {
        for view in scrollView.subviews {
            view.removeFromSuperview() // Удаление старых представлений
        }
        
        var xOffset: CGFloat = 0
        for item in items {
            let label = UILabel()
            label.text = item
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .white
            label.backgroundColor = backgroundColor
            label.layer.cornerRadius = 10
            label.layer.masksToBounds = true
            label.textAlignment = .center
            label.sizeToFit()
            label.frame = CGRect(x: xOffset, y: 0, width: label.frame.width + 20, height: 30)
            
            scrollView.addSubview(label)
            xOffset += label.frame.width + 10
        }
        
        scrollView.contentSize = CGSize(width: xOffset, height: 30)
    }
}
