import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlayListResponse
}

struct CategoryPlaylistsResponse: Codable {
    let playlists: PlayListResponse
}

struct PlayListResponse: Codable {
    let items: [Playlist]
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
