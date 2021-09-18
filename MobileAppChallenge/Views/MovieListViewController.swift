import UIKit

protocol MovieSelectionDelegate: class {
    func didSelectMovie(imdbId: String)
}

class MovieListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var viewModel: MovieListViewModel? {
        didSet {
            viewModel?.viewDelegate = self
        }
    }
    
    var loading: Bool = false
    
    func refreshDisplay() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as! MovieListTableViewCell
        if let viewModel = viewModel {
            cell.update(with: viewModel.moviesInRow(indexPath.row))
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let viewModel = viewModel {
            if indexPath.row == viewModel.numberOfRows - 1 && !loading && !viewModel.listCompleted {
                loading = true
                viewModel.nextPage()
            }
        }
    }
}

extension MovieListViewController: MovieSelectionDelegate {
    func didSelectMovie(imdbId: String) {
        viewModel?.openMovie(imdbId: imdbId)
    }
}

extension MovieListViewController: ListViewModelViewDelegate {
    func itemsDidChange(viewModel: MovieListViewModel) {
        refreshDisplay()
        loading = false
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        loading = true
        viewModel?.newSearch(for: searchText)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}
