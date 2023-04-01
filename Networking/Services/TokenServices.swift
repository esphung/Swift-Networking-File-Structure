import Foundation

struct TokenServices{
    
    static let shared = TokenServices()
    let postSession = URLSession(configuration: .default)
    let parameters = [ "YOUR_KEY": "YOUR_VALUES" ]
    // NOTE : NOT ALL Request requires parameters. You can pass nil in the configureHTTPRequest() method for the parameter argument.
    func getToken(_ completion: @escaping (Result<Token>) -> ()) {
        
        do{
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: .posts, with: parameters, and: .get, contains: nil)
            
            postSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                
                    case .success:
                        let result = try? JSONDecoder().decode(Token.self, from: unwrappedData)
                        completion(Result.success(result!))    
                    case .failure:
                        completion(Result.failure(HTTPNetworkError.decodingFailed))
                    }
                }
            }.resume()
        }catch{
            
            completion(Result.failure(HTTPNetworkError.badRequest))
        } 
    }
}
