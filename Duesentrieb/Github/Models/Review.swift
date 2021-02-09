import Foundation

struct Review: Codable {
    let id: Int
    let state: String
    let user: User
    let body: String
    
    var approved: Bool { state == "APPROVED" }
}
