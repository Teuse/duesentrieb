import Foundation
import Combine

class GithubState: ObservableObject {
    private let client: GithubClient
    private var cancelBag = CancelBag()
    
    let uuid = UUID()
    let user: User
    let service: Service
    
    @Published private(set) var requestState = RequestState.unknown
    @Published private(set) var repoStates: [RepositoryState]
    
    var url: URL { client.url }
    var token: String { client.token }
    
    var numberOfOpenPullRequests: Int {
        return repoStates.map{ $0.numberOfOpenPullRequests }.reduce(0, +)
    }

    var numberOfOpenReviewRequests: Int {
        return repoStates.map{ $0.numberOfOpenReviewRequests }.reduce(0, +)
    }
    
    //MARK:- Life Circle
    
    init(service: Service, connection: ServiceConnection) {
        self.service = service
        self.client = connection.client
        self.user = connection.user
        self.repoStates = connection.repositories
            .map{ RepositoryState(repo: $0, user: connection.user) }
    }
    
    //MARK:- Private Functions
    
    func updateViewModel() {
        GithubState.fetchRepositories(client: client, user: user)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("ERROR: failed to update PullRequests: \(error)")
                    self.requestState = .error
                } else {
                    self.requestState = .done
                }
            }, receiveValue: { [weak self] repositories in
                guard let `self` = self else { return }
                self.repoStates = repositories
                    .map{ RepositoryState(repo: $0, user: self.user) }
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
                print("Update States in \(timeInterval) ms")
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
