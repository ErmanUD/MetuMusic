import UIKit

class LibraryViewController: UIViewController {
    
    // MARK: - Properties
    
    private let playlistsVC = LibraryPlaylistsViewController()
    private let albumsVC = LibraryAlbumsViewController()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isPagingEnabled = true
        
        return sv
    }()
    
    private let toggleView = LibraryToggleView()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(toggleView)
        view.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.width, height: scrollView.height)
        
        addChildren()
        updateBarButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top + 55,
            width: view.width,
            height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 65
        )
        toggleView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: 200,
            height: 55
        )
    }
    
    // MARK: - ViewMethods /
    
    private func addChildren() {
        addChild(playlistsVC)
        scrollView.addSubview(playlistsVC.view)
        playlistsVC.view.frame = CGRect(x: 0, y: 0, width: view.width, height: scrollView.height)
        playlistsVC.didMove(toParent: self)
    }
    
    private func updateBarButtons() {
            switch toggleView.state {
            case .playlist:
                navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
            }
        }
    
    @objc private func didTapAdd() {
        playlistsVC.showCreatePlaylistAlert()
    }
}
