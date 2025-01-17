//
//  BirdViewModel.swift
//  BirdApiExample
//
//  Created by Reed Gantz on 1/16/25.
//

import Foundation

struct Bird: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
}

@MainActor
class BirdViewModel: ObservableObject {
    @Published var birds: [Bird] = []
    @Published var isLoading: Bool = true
    
    func fetchBirds() async {
        isLoading = true
        
        if let url = URL(string: "https://freetestapi.com/api/v1/birds") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                birds = try JSONDecoder().decode([Bird].self, from: data)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
        } else {
            print("Invalid URL")
        }
        isLoading = false
    }

}
