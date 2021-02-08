import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let owner: User
}
