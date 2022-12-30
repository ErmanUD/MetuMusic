import UIKit

class NewReleasesCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleasesCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(numberOfTracksLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let imageSize: CGFloat = contentView.height - 10
        
        let albumLabelSize = albumNameLabel.sizeThatFits(
            CGSize(
                width: contentView.width - 10,
                height: contentView.height - 10
            )
        )
        
        let artistLabelSize = artistNameLabel.sizeThatFits(
            CGSize(
                width: contentView.width - 10,
                height: contentView.height - 10
            )
        )
        
        let numberOfTracksLabelSize = numberOfTracksLabel.sizeThatFits(
            CGSize(
                width: contentView.width - 10,
                height: contentView.height - 10
            )
        )
        
        artistNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        
        albumNameLabel.frame = CGRect(x: albumCoverImageView.right + 10,
                                      y: albumCoverImageView.top + 5,
                                      width: albumLabelSize.width,
                                      height: albumLabelSize.height)
        
        artistNameLabel.frame = CGRect(x: albumCoverImageView.right + 10,
                                       y: albumNameLabel.bottom + 5,
                                       width: artistLabelSize.width,
                                       height: artistLabelSize.height)
        
        numberOfTracksLabel.frame = CGRect(x: albumCoverImageView.right + 10,
                                           y: artistNameLabel.bottom + 5,
                                           width: numberOfTracksLabelSize.width,
                                           height: numberOfTracksLabelSize.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNameLabel.text =  nil
        numberOfTracksLabel.text = nil
    }
    
    func configure(with viewModel: NewReleasesCellViewModel) {
        albumNameLabel.text = viewModel.name
        artistNameLabel.text =  viewModel.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
//        albumCoverImageView.image = loadImage(url: viewModel.artworkURL)
        albumCoverImageView.loadFrom(URLAddress: viewModel.artworkURL)
    }
    
//    func loadImage(url: URL?) -> UIImage {
//        guard let url = url else {
//            return UIImage(systemName: "photo")!
//        }
//
//        if let data = try? Data(contentsOf: url) {
//            if let image = UIImage(data: data) {
//
//                return image
//            }
//        }
//
//        return UIImage(systemName: "photo")!
//    }
}
