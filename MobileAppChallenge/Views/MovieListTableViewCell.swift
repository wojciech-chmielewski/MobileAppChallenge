import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var image0: UIImageView!
    @IBOutlet private weak var label0: UILabel!
    @IBOutlet private weak var image1: UIImageView!
    @IBOutlet private weak var label1: UILabel!
    
    weak var delegate: MovieSelectionDelegate?
    
    private lazy var images: [UIImageView] = [image0, image1]
    private lazy var labels: [UILabel] = [label0, label1]
    private var imdbIds: [String?] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for i in 0..<images.count {
            images[i].isUserInteractionEnabled = true
            images[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
            images[i].tag = i
        }
    }
    
    func update(with movies: [Movie?]) {
        for i in 0..<images.count {
            updateItemView(imageView: images[i], label: labels[i], movie: movies[i])
        }
        imdbIds = movies.map { $0?.imdbID }
    }
    
    private func updateItemView(imageView: UIImageView, label: UILabel, movie: Movie?) {
        if let movie = movie {
            label.text = movie.title
            label.isHidden = false
            imageView.isHidden = false
            imageView.image = nil
            if let url = URL(string: movie.poster) {
                imageView.load(url: url)
            }
        } else {
            label.isHidden = true
            imageView.isHidden = true
        }
    }
    
    @objc private func imageTapped(recognizer: UITapGestureRecognizer) {
        let imdbId = imdbIds[recognizer.view?.tag ?? 0]
        print("Image was tapped, imdbId : \(String(describing: imdbId)))")
        if let imdbId = imdbId {
            delegate?.didSelectMovie(imdbId: imdbId)
        }
    }
}
