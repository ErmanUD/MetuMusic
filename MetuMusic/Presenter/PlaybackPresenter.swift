import Foundation
import UIKit
import AVFoundation

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: String? { get }
}

final class PlaybackPresenter {
    static let shared = PlaybackPresenter()
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        } else if let _ = self.playerQueue, !tracks.isEmpty {
            return tracks[index]
        }
        return nil
    }
    
    var playerVC: PlayerViewController?
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        guard let url = URL(string: track.preview_url ?? "") else { return }
        player = AVPlayer(url: url)
        player?.volume = 0.5
        
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
    func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        self.tracks = tracks
        self.track = nil
        
        let items: [AVPlayerItem] = tracks.compactMap({
            guard let url = URL(string: $0.preview_url ?? "") else { return nil }
            return AVPlayerItem(url: url)
        })
        self.playerQueue = AVQueuePlayer(items: items)
        self.playerQueue?.play()
        
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
        self.playerVC = vc
    }
}

extension PlaybackPresenter: PlayerViewControllerDelegate {

    func didTapBackward() {
        if tracks.isEmpty {
            player?.pause()
        } else if let _ = playerQueue?.items().first {
            playerQueue?.pause()
        }
    }
    
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        else if let player = playerQueue {
            if player.timeControlStatus == .playing {
                player.pause()
            } else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didPause() {
        player?.pause()
        playerQueue?.pause()
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            player?.pause()
        } else if let player = playerQueue {
            player.pause()
            player.advanceToNextItem()
            player.play()
            index += 1
            playerVC?.refreshUI()
        }
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
}

extension PlaybackPresenter: PlayerDataSource {
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: String? {
        return currentTrack?.album?.images.first?.url
    }
}
