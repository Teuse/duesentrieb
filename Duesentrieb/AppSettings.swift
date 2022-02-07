import Foundation

struct Service: Equatable, Codable {
    let type: ServiceType
    let url: String
    let token: String
}

class AppSettings {
    private static let defaults = UserDefaults.standard
    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()
    
    private static let servicesKey = "services_key"
    private static let versionNumberKey = "CFBundleShortVersionString"
    private static let buildNumberKey = "CFBundleVersion"
    
    //MARK:- Service Connections
    
    static var services: [Service] = {
        guard let data = defaults.data(forKey: servicesKey),
              let svc = try? decoder.decode([Service].self, from: data) else {
                  print("error reading from userDefaults.")
                  return []
              }
        return svc
    }()
    
    static func add(service: Service) {
        services.append(service)
        let data = try? encoder.encode(services)
        guard let data = data else { print("error updating userDefaults."); return assertionFailure() }
        defaults.set(data, forKey: servicesKey)
    }
    
    static func remove(service: Service) {
        services.removeAll(where: { $0 == service })
        let data = try? encoder.encode(services)
        guard let data = data else { print("error updating userDefaults."); return assertionFailure() }
        defaults.set(data, forKey: servicesKey)
    }
    
    //MARK:- Version Info
    
    static var versionNumber: String = {
        (Bundle.main.infoDictionary?[versionNumberKey] as? String) ?? ""
    }()
    static var buildNumber: String = {
        (Bundle.main.infoDictionary?[buildNumberKey] as? String) ?? ""
    }()
}
