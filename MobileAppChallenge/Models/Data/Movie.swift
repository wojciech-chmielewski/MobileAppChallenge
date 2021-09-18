import Foundation

struct Movie: Codable {
    enum TypeEnum: String, Codable {
        case movie
    }
    
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
