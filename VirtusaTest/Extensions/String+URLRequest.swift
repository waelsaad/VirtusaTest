import Foundation

extension String {
    func urlRequest(method: String = "GET") -> URLRequest {
        let url : URL = {
            let url = URL(string: self)!
            return url
        }()

        // Create request
        var request = URLRequest(url: url)
        // Setup HTTP method
        request.httpMethod = method
        return request
    }
}
