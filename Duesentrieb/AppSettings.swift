import Foundation

class AppSettings {
    private static let defaults = UserDefaults.standard
    
    private static let githubUrlKey = "github_url_key"
    private static let githubTokenKey = "github_token_key"
    
    static var githubUrl: URL? {
        get { defaults.url(forKey: githubUrlKey) }
        set { defaults.set(newValue, forKey: githubUrlKey) }
    }
    
    static var githubToken: String? {
        get { defaults.string(forKey: githubTokenKey) }
        set { defaults.set(newValue, forKey: githubTokenKey) }
    }
}
