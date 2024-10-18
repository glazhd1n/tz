import Foundation

class MovieService {
    private let apiKey = "API_KEY"
    private let baseURL = "https://movies-tv-shows-database.p.rapidapi.com/"
    private let apiHost = "movies-tv-shows-database.p.rapidapi.com"
    
    func fetchTrendingMovies(completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        let headers = [
            "x-rapidapi-key": apiKey,
            "x-rapidapi-host": baseURL,
            "Type": "get-trending-movies",
        ]
        
        let endPointUrl = "\(baseURL)?page=1"
        
        guard let url = URL(string: endPointUrl) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "No Data", code: -1, userInfo: nil)
                completion(.failure(noDataError))
                return
            }
            
            do {
                let movieListResponse = try JSONDecoder().decode(MovieListResponse.self, from: data)
                completion(.success(movieListResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
    
    func fetchMovieDetails(by id: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        let headers = [
            "x-rapidapi-key": apiKey,
            "x-rapidapi-host": apiHost,
            "Type": "get-movie-details"
        ]
        
        let endPointUrl = "\(baseURL)?movieid=\(id)"
        
        guard let url = URL(string: endPointUrl) else {
            let invalidUrlError = NSError(domain: "Invalid URL", code: -1, userInfo: nil)
            completion(.failure(invalidUrlError))
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "No Data", code: -1, userInfo: nil)
                completion(.failure(noDataError))
                return
            }
            
            do {
                let movieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                completion(.success(movieDetail))
            } catch {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }

}
