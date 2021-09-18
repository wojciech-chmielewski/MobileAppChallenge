import Foundation

class OmdbMovieListRepo: MovieListRepo, MovieDetailsRepo {
    
    private let urlSession = URLSession(configuration: .default)
    
    func items(for string: String, page: Int, _ completion: @escaping (_ items: Items?) -> Void) {
        sendRequest(stringUrl: "http://www.omdbapi.com/?apikey=b9bd48a6&s=\(string)&type=movie&page=\(page)") { data in
            guard let data = data else {
                return
            }
            do {
                let movieListResponse = try JSONDecoder().decode(MovieListResponse.self, from: data)
                let movies = Items(movies: movieListResponse.movies, totalResults: Int(movieListResponse.totalResults) ?? 0)
                completion(movies)
            } catch {
                print("Couldn't parse MovieListResponse data: \(error)")
                completion(nil)
            }
        }
    }
    
    func details(for imdbId: String, _ completion: @escaping (_ items: MovieDetails?) -> Void) {
        sendRequest(stringUrl: "https://www.omdbapi.com/?apikey=b9bd48a6&i=\(imdbId)") { data in
            guard let data = data else {
                return
            }
            do {
                let movieDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
                completion(movieDetails)
            } catch {
                print("Couldn't parse MovieListResponse data: \(error)")
                completion(nil)
            }
        }
    }
    
    private func sendRequest(stringUrl: String, _ completion: @escaping (_ data: Data?) -> Void) {
        guard let url = URL(string: stringUrl) else {
            print("Invalid url: \(stringUrl)")
            completion(nil)
            return
        }
        print("Sending request with url: \(stringUrl)")
        
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) -> Void in
            guard error == nil else {
                print("Request failed with error: \(String(describing: error))")
                completion(nil)
                return
            }
            
            guard let jsonData = data else {
                print("Received nil data")
                completion(nil)
                return
            }
            
            completion(jsonData)
        }
        
        task.resume()
    }
}

