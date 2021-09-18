import UIKit

protocol DetailCoordinatorDelegate: class {
    func detailCoordinatorDidFinish()
}

class DetailCoordinator {
    
    private weak var delegate: DetailCoordinatorDelegate?
    private var window: UIWindow
    private var vc: MovieDetailsViewController?
    
    init(window: UIWindow) {
        self.window = window
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "Detail") as? MovieDetailsViewController
    }
    
    func start(imdbId: String, delegate: DetailCoordinatorDelegate){
        self.delegate = delegate
        
        let viewModel =  MovieDetailsViewModel(imdbId: imdbId)
        viewModel.movieListRepo = OmdbMovieListRepo()
        viewModel.coordinatorDelegate = self
        vc?.viewModel = viewModel
        
        window.rootViewController = vc
    }
}

extension DetailCoordinator: DetailViewModelCoordinatorDelegate {
    func detailViewModelDidEnd(_ viewModel: MovieDetailsViewModel) {
        delegate?.detailCoordinatorDidFinish()
    }
}
