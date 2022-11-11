import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
//    let explicit_content: [String: Int]
//    let external_urls: [String: String]
    let id: String
    let product: String
    let images: [APIImage]
}
