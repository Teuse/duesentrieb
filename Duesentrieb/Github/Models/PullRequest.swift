import Foundation

enum MergeableState: String, Codable {
    case behind = "behind"
    case blocked = "blocked"
    case clean = "clean"
    case dirty = "dirty"
    case draft = "draft"
    case hasHooks = "has_hooks"
    case unknown = "unknown"
    case unstable = "unstable"
}

struct PullRequest: Codable {
    let id: Int
    let url: String
    let title: String
    let user: User
    let number: Int
    let state: String
    let head: Commit
    
    let mergeable: Bool?
    let mergeableState: MergeableState
    
    let requestedReviewers: [User]
    
    func isReviewer(user: User) -> Bool {
        return requestedReviewers.contains(where: { $0.id == user.id })
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, user, number, state, head
        case mergeable
        case requestedReviewers = "requested_reviewers"
        case url = "html_url"
        case mergeableState = "mergeable_state"
    }
}
