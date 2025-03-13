public class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    struct UnexpectedValuesRepresentationError: Error {}
    
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failiure(error))
            } else if let data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failiure(UnexpectedValuesRepresentationError()))
            }
        }.resume()
    }
}