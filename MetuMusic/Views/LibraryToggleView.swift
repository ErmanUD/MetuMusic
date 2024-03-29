import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {
    
    // MARK: - Properties
    
    var state: State = .playlist
    weak var delegate: LibraryToggleViewDelegate?

    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        
        return button
    }()

    private let toggleIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        
        return view
    }()
    
    // MARK: - INIT

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(playlistButton)
        addSubview(toggleIndicator)
        
        playlistButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Act

    @objc private func didTapPlaylists() {
        state = .playlist
        UIView.animate(withDuration: 0.2) {
            self.setupLayoutIndicator()
        }
        delegate?.libraryToggleViewDidTapPlaylists(self)
    }

    func updateState(_ state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.setupLayoutIndicator()
        }
    }
    
    // MARK: - UI

    override func layoutSubviews() {
        super.layoutSubviews()
        playlistButton.frame = CGRect(
            x: 0,
            y: 0,
            width: 100,
            height: 40
        )

        setupLayoutIndicator()
    }

    func setupLayoutIndicator() {
        switch state {
        case .playlist:
            toggleIndicator.frame = CGRect(
                x: 0,
                y: playlistButton.bottom,
                width: 100,
                height: 3
            )
        }
    }
}

// MARK: - State Enum

extension LibraryToggleView {
    enum State {
        case playlist
    }
}
