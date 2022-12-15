//
//  SearchResult.swift
//  MetuMusic
//
//  Created by onedio on 12.12.2022.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
}
