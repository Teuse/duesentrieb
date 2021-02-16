import Foundation
import SwiftUI

class RootViewModel: ObservableObject {
    private var cancelBag = CancelBag()
    
    @Published private(set) var connectionState = RequestState.unknown
    @Published private(set) var gitViewModel: GithubViewModel?
    
    init() {
        clickConnect(gitUrl: AppSettings.githubUrl, token: AppSettings.githubToken)
    }
    
    var myPullRequestsCount: Int {
        guard let model = gitViewModel else { return 0 }
        return model.myPullRequests.count
    }
    
    var myReviewRequestsCount: Int {
        guard let model = gitViewModel else { return 0 }
        return model.myReviewRequests.count
    }

    func clickConnect(gitUrl: String, token: String) {
        guard connectionState != .requesting else { return }
        
        let client = GithubClient(session: URLSession.shared,
                                  baseUrl: gitUrl, token: token)
        
        connectionState = .requesting
        fetchUser(client: client)
    }
    
    func clickDisconnect() {
        AppSettings.githubUrl = ""
        AppSettings.githubToken = ""
        connectionState = .unknown
        gitViewModel = nil
    }
    
    func clickQuitApp() {
        NSApplication.shared.terminate(nil)
    }
    
    //MARK:- Private Functions
    
    private func fetchUser(client: GithubClient) {
        client.loginUser()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                
                if case let .failure(error) = completion {
                    self.onFetchError(error: error)
                }
            }, receiveValue: { user in
                self.didFetch(user: user, client: client)
            })
            .store(in: cancelBag)
    }
    
    private func didFetch(user: User, client: GithubClient) {
        self.connectionState = .done
        AppSettings.githubUrl = client.baseUrl
        AppSettings.githubToken = client.token
        
        gitViewModel = GithubViewModel(client: client, user: user)
    }
    
    private func onFetchError(error: Error) {
        print("Couldn't fetch user. Error: \(error)")
        connectionState = .error
    }
}
