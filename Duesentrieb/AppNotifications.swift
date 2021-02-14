import Foundation
import Combine

class AppNotifications {
    
//    private static let nc = NotificationCenter.default
//    private static let addRepositoryKey = Notification.Name("com.duesentrieb.add_repository")
//    private static let deleteRepositoryKey = Notification.Name("com.duesentrieb.delete_repository")
//
//    //MARK: Add Repository
//    static func postAddRepository(repoPath: RepositoryPath) {
//        nc.post(name: addRepositoryKey, object: nil, userInfo: repoPath.asDict)
//    }
//    
//    static func addRepositoryPublisher() -> AnyPublisher<RepositoryPath, NotificationCenter.Publisher.Failure> {
//        return nc.publisher(for: addRepositoryKey)
//            .map { RepositoryPath(dict: $0.userInfo as! [String:String])! }
//            .eraseToAnyPublisher()
//    }
//    
//    //MARK: Delete Repository
//    static func postDeleteRepository(repoPath: RepositoryPath) {
//        nc.post(name: deleteRepositoryKey, object: nil, userInfo: repoPath.asDict)
//
//    }
//    
//    static func deleteRepositoryPublisher() -> AnyPublisher<RepositoryPath, NotificationCenter.Publisher.Failure> {
//        return nc.publisher(for: deleteRepositoryKey)
//            .map({ RepositoryPath(dict: $0.userInfo as! [String:String])! })
//            .eraseToAnyPublisher()
//    }
}
