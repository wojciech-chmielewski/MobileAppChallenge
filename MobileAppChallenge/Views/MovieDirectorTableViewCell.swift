import UIKit

class MovieDirectorTableViewCell: UITableViewCell {
    @IBOutlet private weak var labelDirector: UILabel!
    @IBOutlet private weak var labelWriter: UILabel!
    @IBOutlet private weak var labelActors: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelDirector.text = ""
        labelWriter.text = ""
        labelActors.text = ""
    }
}

extension MovieDirectorTableViewCell: MovieDetailsTableViewCell {
    func update(with movieDetails: MovieDetails) {
        labelDirector.text = "Director: \(movieDetails.director)"
        labelWriter.text = "Writer: \(movieDetails.writer)"
        labelActors.text = "Actors: \(movieDetails.actors)"
        labelActors.sizeToFit()
    }
}
