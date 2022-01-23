import Apollo

class RequestLoggingInterceptor: ApolloInterceptor {
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
            
            //TODO: .debug
            print("Outgoing request: \(request)")
            chain.proceedAsync(request: request,
                               response: response,
                               completion: completion)
        }
}
