import Foundation

struct ServiceConnection {
    let type: ServiceType
    let user: User
    let repositories: [Repository]
    let client: GithubClient
}
