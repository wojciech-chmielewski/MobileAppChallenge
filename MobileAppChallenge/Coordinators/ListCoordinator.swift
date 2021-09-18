import UIKit

protocol ListCoordinatorDelegate: class {
    func didSelectData(imdbId: String)
}

class ListCoordinator {
    
    private var window: UIWindow
    private weak var delegate: ListCoordinatorDelegate?
    private var vc: MovieListViewController?
    
    init(window: UIWindow) {
        self.window = window
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "List") as? MovieListViewController
    }
    
    func start(delegate: ListCoordinatorDelegate) {
        self.delegate = delegate
        
        let viewModel =  MovieListViewModel()
        viewModel.movieListRepo = OmdbMovieListRepo()
        viewModel.coordinatorDelegate = self
        vc?.viewModel = viewModel
        
        window.rootViewController = vc
    }
    
    func restart() {
        window.rootViewController = vc
    }
}

extension ListCoordinator: ListViewModelCoordinatorDelegate {
    func listViewModelDidSelectData(_ viewModel: MovieListViewModel, imdbId: String) {
        delegate?.didSelectData(imdbId: imdbId)
    }
}
