//
//  ContentView.swift
//  BirdApiExample
//
//  Created by Reed Gantz on 1/16/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var birdViewModel: BirdViewModel = BirdViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if (birdViewModel.isLoading){
                    ProgressView()
                }
                else{
                    List(birdViewModel.birds){ bird in
                        VStack (alignment: .leading){
                            Text(bird.name)
                            Text(bird.description).font(.caption)
                        }
                    }
                }
            }
            .task{
                await birdViewModel.fetchBirds()
            }
            .navigationTitle("Birds 🪶")
        }
    }
}

#Preview {
    ContentView()
}
