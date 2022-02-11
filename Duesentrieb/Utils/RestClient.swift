import Foundation
import Combine

enum BackendError: Error {
    case jsonEncodingError
    case jsonDecodingError
    case networkError
    case apiError(Int, String)
    case unknown
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct RestClient {
    
    typealias Header = [String : String]
    
    // -----------------------------------------------------------------------------------------
    //MARK: - Generic GET Requests
    
    static func modelForRequest<T>(method: HttpMethod, url: URL, header: Header, session: URLSession) -> AnyPublisher<T, BackendError> where T: Codable {
        let request = createRequest(method: method, url: url, header: header)
        return urlDataTask(request: request, session: session)
            .mapError   { error -> BackendError in return mapErrorIfNeeded(error, to: .unknown) }
            .decode(type: T.self, decoder: decoder())
            .mapError   { error -> BackendError in return mapErrorIfNeeded(error, to: .jsonDecodingError) }
            .eraseToAnyPublisher()
    }
    
    static func modelForRequest<T, P>(data: P, method: HttpMethod, url: URL, header: Header, session: URLSession) -> AnyPublisher<T, BackendError> where T: Codable, P: Codable {
        return Just(data)
            .encode(encoder: encoder())
            .mapError   { error -> BackendError in return mapErrorIfNeeded(error, to: .jsonEncodingError) }
            .map        { data -> URLRequest in return createRequest(data: data, method: method, url: url, header: header) }
            .flatMap    { urlDataTask(request: $0, session: session) }
            .mapError   { error -> BackendError in return mapErrorIfNeeded(error, to: .unknown) }
            .decode(type: T.self, decoder: decoder())
            .mapError   { error -> BackendError in return mapErrorIfNeeded(error, to: .jsonDecodingError) }
            .eraseToAnyPublisher()
    }
    
    static func arrayForRequest<T>(method: HttpMethod, url: URL, header: Header, session: URLSession) -> AnyPublisher<[T], BackendError> where T: Codable {
        let request = createRequest(method: method, url: url, header: header)
        return urlDataTask(request: request, session: session)
            .mapError   { error -> BackendError in return mapErrorIfNeeded(error, to: .unknown) }
            .decode(type: [T].self, decoder: decoder())
            .mapError   { error -> BackendError in return mapErrorIfNeeded(error, to: .jsonDecodingError) }
            .eraseToAnyPublisher()
    }
    
    static func arrayForRequest<T, P>(data: P, method: HttpMethod, url: URL, header: Header, session: URLSession) -> AnyPublisher<[T], BackendError> where T: Codable, P: Codable {
        return Just(data)
            .encode(encoder: encoder())
            .mapError   { error -> BackendError in return mapErrorIfNeeded(error, to: .jsonEncodingError) }
            .map        { data -> URLRequest in return createRequest(data: data, method: method, url: url, header: header) }
            .flatMap    { urlDataTask(request: $0, session: session) }
            .mapError   { error -> BackendError in return mapErrorIfNeeded(error, to: .unknown) }
            .decode(type: [T].self, decoder: decoder())
            .mapError   { error -> BackendError in return mapErrorIfNeeded(error, to: .jsonDecodingError) }
            .eraseToAnyPublisher()
    }
    
    
    
    // -----------------------------------------------------------------------------------------
    //MARK: - Private Helper functions
    
    static func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        return decoder
    }
    
    static private func encoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.iso8601Full)
        return encoder
    }
    
    static private func urlDataTask(request: URLRequest, session: URLSession) -> Publishers.TryMap<URLSession.DataTaskPublisher, Data> {
        return session.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw BackendError.networkError
                }
                guard response.statusCode == 200 else {
                    guard let errMsg = String(data: output.data, encoding: .utf8) else {
                        throw BackendError.networkError
                    }
                    throw BackendError.apiError(response.statusCode, errMsg)
                }
                return output.data
            }
    }
    
    //   static private func urlUploadTask(request: URLRequest, data: Data) -> Publishers.TryMap<URLSession.UploadTaskPublisher, Data> {
    //      return URLSession.shared.uploadTaskPublisher(for: request, from: data)
    //         .tryMap { output in
    //            guard let response = output.response as? HTTPURLResponse else {
    //               throw BackendError.networkError
    //            }
    //            guard response.statusCode == 200 else {
    //               guard let errMsg = String(data: output.data, encoding: .utf8) else {
    //                  throw BackendError.networkError
    //               }
    //               throw BackendError.apiError(response.statusCode, errMsg)
    //            }
    //            return output.data
    //      }
    //   }
    
    static private func createRequest(method: HttpMethod, url: URL, header: Header) -> URLRequest {
        return createRequestGeneric(data: nil, method: method, url: url, header: header)
    }
    
    static private func createRequest(data: Data, method: HttpMethod, url: URL, header: Header) -> URLRequest {
        return createRequestGeneric(data: data, method: method, url: url, header: header)
    }
    
    static private func createRequestGeneric(data: Data?, method: HttpMethod, url: URL, header: Header) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        for (key, value) in header {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        if let data = data {
            urlRequest.httpBody = data
        }
        return urlRequest
    }
    
    static private func mapErrorIfNeeded(_ error: Error, to backendError: BackendError) -> BackendError {
        if let error = error as? BackendError {
            return error
        }
        return backendError
    }
}
