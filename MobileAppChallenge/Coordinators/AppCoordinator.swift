import UIKit

class AppCoordinator {
    
    private var window: UIWindow
    private lazy var listCoordinator = ListCoordinator(window: window)
    private lazy var detailCoordinator = DetailCoordinator(window: window)
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        listCoordinator.start(delegate: self)
    }
}

extension AppCoordinator: ListCoordinatorDelegate {
    func didSelectData(imdbId: String) {
        detailCoordinator.start(imdbId: imdbId, delegate: self)
    }
}

extension AppCoordinator: DetailCoordinatorDelegate {
    func detailCoordinatorDidFinish() {
        listCoordinator.restart()
    }
}
