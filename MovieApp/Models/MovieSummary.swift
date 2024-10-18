import Foundation

struct MovieListResponse: Codable {
    let movieResults: [MovieSummary]
    let results: Int
    let totalResults: String
    let status: String
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case movieResults = "movie_results"
        case results
        case totalResults = "Total_results"
        case status
        case statusMessage = "status_message"
    }
}

struct MovieSummary: Codable {
    let title: String
    let year: String?
    let imdbId: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case year
        case imdbId = "imdb_id"
    }
}
