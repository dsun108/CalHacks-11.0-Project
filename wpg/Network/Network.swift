import SwiftUI
import Foundation

class Network: ObservableObject {
    @Published var users: [Model] = []
    struct Message: Encodable {

        let goals: String
        let experience: String
        let time: String

    }
    func getUsers() {
        guard let url = URL(string: "http://127.0.0.1:5000") else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode([Model].self, from: data)
                        self.users = decodedUsers
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
    
    func sendData(goal:String,exp:String,days:String){
        guard let url = URL(string: "http://127.0.0.1:5000/userData") else { fatalError("Missing URL") }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let message = Message(
            goals: goal,
            experience: exp,
            time: days
        )
        
        let data = try! JSONEncoder().encode(message)
        
        urlRequest.httpBody = data
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode

            if statusCode == 200 {
                print("SUCCESS")
            } else {
                print("FAILURE")
            }
        }
        task.resume()
    }
}
