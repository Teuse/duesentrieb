import Foundation

struct Commit: Codable {
    let sha: String
    let user: User
    let repo: Repository
}
