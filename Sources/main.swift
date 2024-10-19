// The Swift Programming Language
// https://docs.swift.org/swift-book
func fetchQuote() {
    let urlString: String = "localhost"
    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return
    }

    var request = URLRequest(url:url)
    request.httpMethod = "GET"

    let task = URLSession.shared.dataTasl(with: request){data, response, error in 
        if let error = error {
            print("API call error: \(error.localizedDescription)")
            return
        } 

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)else{
            print("Bad response code")
            return
        }

        do {
            guard let jsonData = data else {
                print("Invalid data")
                return
            }
            let decode = JSONDecoder()
            let result = try decoder.decode(QuotesArray.self, from: jsonData)

            print(result)
            DispatchQueue.main.async {
                self.fetchedQuote = result[0]
            }
        } catch {
            print("Error decoding response data")
        }
    }
    task.resume()

}
print("here\n")
fetchQuote()