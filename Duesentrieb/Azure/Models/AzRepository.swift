import Foundation

struct AzRepositoryContainer: Codable {
    let value: [AzRepository]
}

struct AzRepository: Codable {
    let id: String
    let name: String
    let url: String
    let project: AzProject
}
