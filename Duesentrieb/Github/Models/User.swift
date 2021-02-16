import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let name: String?
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, login
        case name
        case avatarUrl = "avatar_url"
    }
    
}
