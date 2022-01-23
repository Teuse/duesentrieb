import Foundation
import SwiftUI

//https://git.daimler.com/api/graphql

class RootViewModel: ObservableObject {
    @Published private(set) var connectionState = RequestState.unknown
    @Published private(set) var gitViewModel: GithubViewModel?
    
    private(set) var myPullRequestsCount: Int = 0
    private(set) var myReviewRequestsCount: Int = 0
    
    init() {
        reconnect()
    }
    
    func clickConnect(gitUrl: URL, token: String) {
        guard connectionState != .requesting else { return }
        connectionState = .requesting
        
        let client = GithubClient(url: gitUrl, token: token)
        client.fetchState(completion: { user, pullRequests in
            self.gitViewModel = GithubViewModel(client: client, user: user, pullRequests: pullRequests)
            self.connectionState = .done
            AppSettings.githubUrl = client.url
            AppSettings.githubToken = client.token
        }) { error in
            print("ERROR: failed to get loginUser: \(error)")
            self.connectionState = .error
        }
    }
    
    func clickDisconnect() {
        AppSettings.githubUrl = nil
        AppSettings.githubToken = nil
        connectionState = .unknown
        gitViewModel = nil
    }
    
    func clickQuitApp() {
        NSApplication.shared.terminate(nil)
    }
    
    private func reconnect() {
        guard let url = AppSettings.githubUrl, let token = AppSettings.githubToken else {
            return
        }
        clickConnect(gitUrl: url, token: token)
    }
}
