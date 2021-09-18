import Foundation

struct MovieListResponse: Codable {
    let movies: [Movie]
    let totalResults, response: String
    
    enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case response = "Response"
    }
}
