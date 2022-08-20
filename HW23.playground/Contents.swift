import Foundation

// request to google.com
getData(urlRequest: "https://google.com") { response, data, error in
    if error.isEmpty {
        print("HTTP/1.1 \(response.statusCode)")
        for (header, value) in response.allHeaderFields {
            print("\(header): \(value)")
        }
        print()
        print(data)
    } else {
        print(error)
    }
}


// request to marvel api
let publicKey = "<your public key>"
let privateKey = "<your private key>"

let timestamp = String(format: "%.0f", Date.init().timeIntervalSince1970)
let stringToHash = timestamp + privateKey + publicKey
let hash = MD5(string: stringToHash)

var components = URLComponents()
components.scheme = "https"
components.host = "gateway.marvel.com"
components.path = "/v1/public/characters"
components.queryItems = [
    URLQueryItem(name: "name", value: "hulk"),
    URLQueryItem(name: "limit", value: "1"),
    URLQueryItem(name: "ts", value: timestamp),
    URLQueryItem(name: "apikey", value: publicKey),
    URLQueryItem(name: "hash", value: hash)
]

let url = components.string ?? ""

getData(urlRequest: url) { response, data, error in
    if error.isEmpty {
        print("HTTP/1.1 \(response.statusCode)")
        for (header, value) in response.allHeaderFields {
            print("\(header): \(value)")
        }
        print()
        print(data)
    } else {
        print(error)
    }
}
