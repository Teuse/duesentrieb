import Foundation

struct RepositoryPath {
    static private let uuidKey = "uuid"
    static private let orgKey = "org"
    static private let repoKey = "repo"
    
    let uuid: UUID
    let org: String
    let repo: String
    
    var pathString: String {
        return "\(org)/\(repo)"
    }
    
    var asDict: [String: String] {
        return [
            RepositoryPath.uuidKey : uuid.uuidString,
            RepositoryPath.orgKey  : org,
            RepositoryPath.repoKey : repo
        ]
    }
    
    init(org: String, repo: String) {
        self.uuid = UUID()
        self.org = org
        self.repo = repo
    }
    
    init?(dict: [String: String]) {
        guard let uuidStr = dict[RepositoryPath.uuidKey],
              let uuid = UUID(uuidString: uuidStr),
              let org = dict[RepositoryPath.orgKey],
              let repo = dict[RepositoryPath.repoKey] else {
            return nil
        }
        self.uuid = uuid
        self.org = org
        self.repo = repo
    }
    
    static func < (lhs: RepositoryPath, rhs: RepositoryPath) -> Bool {
        return lhs.org.lowercased() < rhs.org.lowercased()
            || (lhs.org.lowercased() == rhs.org.lowercased() && lhs.repo.lowercased() < rhs.repo.lowercased())
    }
}
