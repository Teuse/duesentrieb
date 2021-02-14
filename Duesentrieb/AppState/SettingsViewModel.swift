import Foundation

class SettingsViewModel: ObservableObject {
    private var cancelBag = CancelBag()
    
    @Published var repoPaths = AppSettings.repoPaths {
        didSet { AppSettings.repoPaths = repoPaths }
    }
    
    func addRepository(org: String, repo: String) {
        let repo = RepositoryPath(org: org, repo: repo)
        repoPaths.append(repo)
        AppNotifications.postAddRepository(repoPath: repo)
    }
    
    func deleteRepository(repoPath: RepositoryPath) {
        repoPaths.removeAll(where: { $0.uuid == repoPath.uuid })
        AppNotifications.postDeleteRepository(repoPath: repoPath)
    }
}
