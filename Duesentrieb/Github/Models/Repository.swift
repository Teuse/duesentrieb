import Foundation

struct Repository {
//    let id: String
    let name: String
    
    init(repo: StateQuery.Data.Viewer.PullRequest.Node.BaseRepository) {
        self.name = repo.name
    }
}
