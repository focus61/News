import Foundation
struct Network {
    static func shared (complitionHandler: @escaping ((NetworkModel) -> ()))  {
        let urlString = "https://api.currentsapi.services/v1/latest-news?apiKey=m7znJe2XUUdTtiqQRtdS-Lipv-aVYX9f-x67-UtLFsoY64hp"
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, _, err in
            guard let data = data else {return}
            do {
                let json = try JSONDecoder().decode(NetworkModel.self, from: data)
                complitionHandler(json)
            } catch {
                print("Error")
            }
        }.resume()
    }
}
