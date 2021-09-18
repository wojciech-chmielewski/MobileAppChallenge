import Foundation

struct Items {
    let movies: [Movie]
    let totalResults: Int
}

protocol MovieListRepo {
    func items(for string: String, page: Int, _ completion: @escaping (_ items: Items?) -> Void)
}

protocol MovieDetailsRepo {
    func details(for imdbId: String, _ completion: @escaping (_ items: MovieDetails?) -> Void)
}
