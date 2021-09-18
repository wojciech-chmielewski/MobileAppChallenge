import Foundation

protocol ListViewModelViewDelegate: class {
    func itemsDidChange(viewModel: MovieListViewModel)
}

protocol ListViewModelCoordinatorDelegate: class {
    func listViewModelDidSelectData(_ viewModel: MovieListViewModel, imdbId: String)
}

class MovieListViewModel {
    
    weak var viewDelegate: ListViewModelViewDelegate?
    weak var coordinatorDelegate: ListViewModelCoordinatorDelegate?
    
    private var movies: [Movie] = [] {
        didSet {
            viewDelegate?.itemsDidChange(viewModel: self)
        }
    }
    
    private var searchString: String = ""
    private var lastPage = 1
    var listCompleted = false
    var movieListRepo: MovieListRepo?
    
    var numberOfRows: Int {
        return (movies.count + 1) / 2
    }
    
    func moviesInRow(_ row: Int) -> [Movie?] {
        return [movie(row * 2), movie(row * 2 + 1)]
    }
    
    private func movie(_ index: Int) -> Movie? {
        if movies.count > index {
            return movies[index]
        }
        return nil
    }
    
    func openMovie(imdbId: String) {
        if let coordinatorDelegate = coordinatorDelegate {
            coordinatorDelegate.listViewModelDidSelectData(self, imdbId: imdbId)
        }
    }
    
    func newSearch(for string: String) {
        listCompleted = false
        lastPage = 1
        searchString = string
        updateMovies()
    }
    
    func nextPage() {
        lastPage += 1
        updateMovies(addToExisting: true)
    }
    
    private func updateMovies(addToExisting: Bool = false) {
        movieListRepo?.items(for: searchString, page: lastPage) { [weak self] items in
            if let items = items, let self = self {
                if addToExisting {
                    self.movies.append(contentsOf: items.movies)
                } else {
                    self.movies = items.movies
                }
                self.listCompleted = (self.movies.count == items.totalResults)
            }
        }
    }
}
