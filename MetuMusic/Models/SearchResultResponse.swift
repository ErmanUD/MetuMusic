import Foundation

struct SearchResultResponse: Codable {
    let albums: SearchAlbumResponse
    let tracks: SearchTrackResponse
    let artists: SearchArtistResponse
}

struct SearchAlbumResponse: Codable {
    let items: [Album]
}

struct SearchTrackResponse: Codable {
    let items: [AudioTrack]
}

struct SearchArtistResponse: Codable {
    let items: [Artist]
}
