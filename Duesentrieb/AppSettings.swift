import Foundation

struct Service: Equatable, Codable {
    let type: ServiceType
    let url: String
    let token: String
    
    var serviceKey: String { "\(type.rawValue).\(url)" }
}

class AppSettings {
    private static let keychainServiceKey = BuildEnv.debug
        ? "com.radler.duesentrieb.dev" : "com.radler.duesentrieb"
    private static let servicesKey = "services_key"
    private static let versionNumberKey = "CFBundleShortVersionString"
    private static let buildNumberKey = "CFBundleVersion"
    
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let keychain: Keychain
    
    //MARK:- Life Circle
    
    init() {
        keychain = Keychain(service: AppSettings.keychainServiceKey)
    }
    
    //MARK:- Version Info
    
    var versionNumber: String = {
        (Bundle.main.infoDictionary?[versionNumberKey] as? String) ?? ""
    }()
    var buildNumber: String = {
        (Bundle.main.infoDictionary?[buildNumberKey] as? String) ?? ""
    }()

    //MARK:- Service Connections
    
    private(set) lazy var services: [Service] = { loadServices() }()
    
    func add(service: Service) {
        services.append(service)
        saveServices()
    }
    
    func remove(service: Service) {
        services.removeAll(where: { $0 == service })
        saveServices()
    }
    
    private func loadServices() -> [Service] {
        guard let data = userDefaults.data(forKey: AppSettings.servicesKey),
              let svc = try? decoder.decode([Service].self, from: data) else {
                  print("error reading from userDefaults.")
                  return []
              }
        return svc
    }
    
    private func saveServices() {
        let data = try? encoder.encode(services)
        guard let data = data else { print("error updating userDefaults."); return assertionFailure() }
        userDefaults.set(data, forKey: AppSettings.servicesKey)
    }
    
    private func saveServicesWithKeychain() {
        //TODO: use keychain
        let svc = services.map{ Service(type: $0.type, url: $0.url, token: "") }
        let data = try? encoder.encode(svc)
        guard let data = data else { print("error updating userDefaults."); return assertionFailure() }
        userDefaults.set(data, forKey: AppSettings.servicesKey)
//        for service in services {
//            keychain.save(password: service.token, account: service.serviceKey)
//        }
    }
    
}
