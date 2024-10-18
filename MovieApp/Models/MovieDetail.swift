import Foundation

struct MovieDetail: Codable {
    let title: String?
    let description: String?
    let tagline: String?
    let year: String?
    let releaseDate: String?
    let imdbID: String?
    let imdbRating: String?
    let voteCount: String?
    let popularity: String?
    let youtubeTrailerKey: String?
    let rated: String?
    let runtime: Int?
    let genres: [String]?
    let stars: [String]?
    let directors: [String]?
    let countries: [String]?
    let language: [String]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case tagline
        case year
        case releaseDate = "release_date"
        case imdbID = "imdb_id"
        case imdbRating = "imdb_rating"
        case voteCount = "vote_count"
        case popularity
        case youtubeTrailerKey = "youtube_trailer_key"
        case rated
        case runtime
        case genres
        case stars
        case directors
        case countries
        case language
    }
}
