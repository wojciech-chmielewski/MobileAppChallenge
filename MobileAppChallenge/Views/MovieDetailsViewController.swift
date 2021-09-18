import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let cellIdentifiers = ["MovieHeaderTableViewCell", "MoviePlotTableViewCell", "MovieDirectorTableViewCell"]
    
    var viewModel: MovieDetailsViewModel? {
        didSet {
            viewModel?.viewDelegate = self
            viewModel?.updateDetails()
        }
    }
    
    func refreshDisplay() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        viewModel?.done();
    }
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellIdentifiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row], for: indexPath)
        if let movieDetails = viewModel?.movieDetails {
            (cell as! MovieDetailsTableViewCell).update(with: movieDetails)
        }
        return cell
    }
}

extension MovieDetailsViewController: DetailViewModelViewDelegate {
    func movieDetailsDidChange(viewModel: MovieDetailsViewModel) {
        refreshDisplay()
    }
}
