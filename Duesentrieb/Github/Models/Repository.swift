import Foundation

struct Repository {
    let name: String
    let nameWithOwner: String
    let pullRequests: [PullRequest]
    
    //MARK:- Public Functions
    
    func reviewRequests(for user: User) -> [PullRequest] {
        return pullRequests.filter{ $0.isReviewRequest(for: user) }
    }
    
    func pullRequests(from user: User) -> [PullRequest] {
        return pullRequests.filter{ $0.isPullRequest(from: user) }
    }
    
    //MARK:- GraphQL Types Initializer
    
    init?(repo: RepositoriesQuery.Data.Viewer.Repository.Node?) {
        guard let repo = repo, let pullRequests = repo.pullRequests.nodes else {
            return nil
            
        }
        self.name = repo.name
        self.nameWithOwner = repo.nameWithOwner
        self.pullRequests = pullRequests.compactMap{$0}.compactMap{ PullRequest(pullRequest: $0) }
    }
    
    init?(repo: OrganizationsQuery.Data.Viewer.Organization.Node.Repository.Node?) {
        guard let repo = repo, let pullRequests = repo.pullRequests.nodes else {
            return nil
        }
        self.name = repo.name
        self.nameWithOwner = repo.nameWithOwner
        self.pullRequests = pullRequests.compactMap{$0}.compactMap{ PullRequest(pullRequest: $0) }
    }
}
