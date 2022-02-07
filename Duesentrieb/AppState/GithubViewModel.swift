import Foundation
import Combine

class GithubViewModel: ObservableObject {
    private let client: GithubClient
    private var cancelBag = CancelBag()
    
    let uuid = UUID()
    let user: User
    
    @Published private(set) var requestState = RequestState.unknown
    @Published private(set) var repoViewModels: [RepositoryViewModel]
    
    var url: URL { client.url }
    var token: String { client.token }
    
    var numberOfOpenPullRequests: Int {
        return repoViewModels.map{ $0.numberOfOpenPullRequests }.reduce(0, +)
    }

    var numberOfOpenReviewRequests: Int {
        return repoViewModels.map{ $0.numberOfOpenReviewRequests }.reduce(0, +)
    }
    
    //MARK:- Life Circle
    
    init(user: User, repositories: [Repository], client: GithubClient) {
        self.client = client
        self.user = user
        self.repoViewModels = repositories
            .map{ RepositoryViewModel(repo: $0, user: user) }
                
        Timer.scheduledTimer(withTimeInterval: 30, repeats: false) { _ in
            self.updateViewModel()
        }
    }
    
    //MARK:- Private Functions
    
    func updateViewModel() {
        GithubViewModel.fetchRepositories(client: client, user: user)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("ERROR: failed to update PullRequests: \(error)")
                    self.requestState = .error
                } else {
                    self.requestState = .done
                }
            }, receiveValue: { [weak self] repositories in
                guard let `self` = self else { return }
                self.repoViewModels = repositories
                    .map{ RepositoryViewModel(repo: $0, user: self.user) }
            })
            .store(in: cancelBag)
    }
    
    static func fetchRepositories(client: GithubClient, user: User) -> AnyPublisher<[Repository], GithubError> {
        let start = DispatchTime.now()
        return Publishers.Zip(client.fetchOrgRepositories(), client.fetchUserRepositories())
            .receive(on: RunLoop.main)
            .map { orgRepos, userRepos in
                let allRepos = orgRepos + userRepos

                let nanoTime = DispatchTime.now().uptimeNanoseconds - start.uptimeNanoseconds
                let timeInterval = Double(nanoTime) / 1_000_000
                print(" ")
                print("####################")
                print("Update ViewModels in \(timeInterval) ms")
                print("### ReviewRequests:")
                let _ = allRepos.map{
                    let blub = $0.reviewRequests(for: user).map{ "\($0.author.login) - \($0.title)" }
                    if !blub.isEmpty {
                        print(blub)
                    }
                }
                print("### PullRequests:")
                let _ = allRepos.map{
                    let blub = $0.pullRequests(from: user).map{ "\($0.author.login) - \($0.title)" }
                    if !blub.isEmpty {
                        print(blub)
                    }
                }
                return allRepos
            }
            .eraseToAnyPublisher()
    }
}
