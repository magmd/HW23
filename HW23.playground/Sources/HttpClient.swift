import Foundation

func isValidURL(url: URL?) -> Bool {
    let schemes = ["https", "http"]

    let urlScheme = url?.scheme ?? ""
    let urlHost = url?.host ?? ""

    if schemes.contains(urlScheme) && !urlHost.isEmpty {
        return true
    }

    return false
}

let sessionConfig: URLSessionConfiguration = {
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForResource = 10
    config.waitsForConnectivity = true
    config.httpAdditionalHeaders = [
        "X-MobDevFactory": "1"
    ]

    return config
}()

let session = URLSession(configuration: sessionConfig)

public func getData(urlRequest: String, completion: @escaping(HTTPURLResponse, String, String) -> Void) {
    let urlRequest = URL(string: urlRequest)

    if !isValidURL(url: urlRequest) {
        completion(HTTPURLResponse.init(), "", "Wrong URL")
        return
    }

    guard let url = urlRequest else { return }

    session.dataTask(with: url) { data, response, error in
        if error != nil {
            completion(HTTPURLResponse.init(), "", "Connection error")
            return
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8) ?? ""
            completion(response, dataAsString, "")
        }
    }.resume()
}
