import UIKit

class MoviePlotTableViewCell: UITableViewCell {
    @IBOutlet private weak var labelCategory: UILabel!
    @IBOutlet private weak var labelTime: UILabel!
    @IBOutlet private weak var labelRating: UILabel!
    @IBOutlet private weak var labelPlot: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelCategory.text = ""
        labelTime.text = ""
        labelRating.text = ""
        labelPlot.text = ""
    }
}

extension MoviePlotTableViewCell: MovieDetailsTableViewCell {
    func update(with movieDetails: MovieDetails) {
        labelCategory.text = movieDetails.genre
        labelTime.text = movieDetails.runtime
        labelRating.text = movieDetails.imdbRating
        labelPlot.text = movieDetails.plot
        labelPlot.sizeToFit()
    }
}
