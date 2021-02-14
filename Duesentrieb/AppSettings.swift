import Foundation

class AppSettings {
    private static let defaults = UserDefaults.standard
    
    private static let githubUrlKey = "github_url_key"
    private static let githubTokenKey = "github_token_key"
    private static let repoPathsKey = "repository_paths_key"
    
    static var githubUrl: String {
        get { defaults.object(forKey: githubUrlKey) as? String ?? "" }
        set { defaults.set(newValue, forKey: githubUrlKey) }
    }
    
    static var githubToken: String {
        get { defaults.object(forKey: githubTokenKey) as? String ?? "" }
        set { defaults.set(newValue, forKey: githubTokenKey) }
    }
    
    static var repoPaths: [RepositoryPath] {
        get {
            let store = defaults.object(forKey: repoPathsKey) as? [[String:String]] ?? []
            return store.map{ RepositoryPath(dict: $0) }.compactMap{ $0 }
        }
        set {
            let store = newValue.map{ $0.asDict }
            defaults.set(store, forKey: repoPathsKey)
            
        }
    }
}
