import Foundation

struct AzOrganizationContainer: Codable {
    let value: [AzOrganization]
}

struct AzOrganization: Codable {
    let id: Int
    let name: String
    let url: String
}
