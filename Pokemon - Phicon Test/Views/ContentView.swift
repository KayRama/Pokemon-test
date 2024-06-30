//
//  ContentView.swift
//  Pokemon - Phicon Test
//
//  Created by Cahaya Ramadhan on 30/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var networkManager = NetworkManager()
    
    var body: some View {
        TabView {
            NavigationView {
                List {
                    ForEach(networkManager.items) { item in
                        ItemRowView(item: item)
                    }

                    // Loading indicator at the end of the list
                    if networkManager.nextURL != nil {
                        ProgressView()
                            .onAppear {
                                networkManager.fetchData()
                            }
                    }
                }
                .navigationTitle("Pokémon")
                .onAppear {
                    if networkManager.items.isEmpty {
                        networkManager.fetchData()
                    }
                }
            }
            .tabItem {
                Label("Pokémon", systemImage: "list.bullet")
            }

//            MyPokemonList()
//                .tabItem {
//                    Label("My Pokémon", systemImage: "star.fill")
//                }
        }
        .environmentObject(networkManager) // Provide networkManager as EnvironmentObject
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





