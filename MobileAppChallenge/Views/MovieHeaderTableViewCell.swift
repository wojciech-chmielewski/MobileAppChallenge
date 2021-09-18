import UIKit

class MovieHeaderTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = ""
        yearLabel.text = ""
    }
}

extension MovieHeaderTableViewCell: MovieDetailsTableViewCell {
    func update(with movieDetails: MovieDetails) {
        titleLabel.text = movieDetails.title
        yearLabel.text = movieDetails.year
        poster.image = nil
        if let url = URL(string: movieDetails.poster) {
            poster.load(url: url)
        }
    }
}
