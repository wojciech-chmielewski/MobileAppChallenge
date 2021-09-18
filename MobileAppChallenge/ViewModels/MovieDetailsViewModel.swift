import Foundation


protocol DetailViewModelViewDelegate: class {
    func movieDetailsDidChange(viewModel: MovieDetailsViewModel)
}

protocol DetailViewModelCoordinatorDelegate: class {
    func detailViewModelDidEnd(_ viewModel: MovieDetailsViewModel)
}

class MovieDetailsViewModel {
    weak var viewDelegate: DetailViewModelViewDelegate?
    weak var coordinatorDelegate: DetailViewModelCoordinatorDelegate?
    
    private(set) var movieDetails: MovieDetails? {
        didSet {
            viewDelegate?.movieDetailsDidChange(viewModel: self)
        }
    }
    
    private let imdbId: String
    var movieListRepo: MovieDetailsRepo?
    
    init(imdbId: String) {
        self.imdbId = imdbId
    }
    
    func updateDetails() {
        movieListRepo?.details(for: imdbId) { [weak self] details in
            if let details = details, let self = self {
                self.movieDetails = details
            }
        }
    }
    
    func done() {
        coordinatorDelegate?.detailViewModelDidEnd(self)
    }
}
