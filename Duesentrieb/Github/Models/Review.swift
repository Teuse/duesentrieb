import Foundation

enum ReviewState: String {
    case unknown = "unknown"
    case approved = "APPROVED"
    case commented = "COMMENTED"
    case changesRequested = "CHANGES_REQUESTED"
}

struct Review: Codable {
    let id: Int
    let user: User
    let body: String
    
    private let stateString: String
    
    var state: ReviewState { ReviewState(rawValue: stateString) ?? .unknown }
    
    enum CodingKeys: String, CodingKey {
        case id, user, body
        case stateString = "state"
    }
}
