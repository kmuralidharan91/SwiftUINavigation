//
//  ContentView.swift
//  NavigationView
//
//  Created by Muralidharan Kathiresan on 18/05/24.
//

import SwiftUI

struct ContinentsView: View {
    @State private var continents: Continents = []
    @EnvironmentObject private var router: Router

    var body: some View {
        NavigationStack(path: $router.routes) {
            List(continents) { continent in
                NavigationLink(value: Route.continent(continent)) {
                    Text(continent.name)
                }
            }
            .onAppear { continents = parseJSON() }
            .navigationTitle("Continents")
            .navigationDestination(for: Route.self) { $0 }
        }
    }
}

struct CountriesListView: View {
    var countries: [Country]

    var body: some View {
        List(countries) { country in
            NavigationLink(value: Route.country(country)) {
                CountryCellView(country: country)
            }
        }
        .navigationTitle("Countries")
    }
}

struct CountryDetailView: View {
    var country: Country
    @EnvironmentObject private var router: Router

    var body: some View {
        Text("Hi Welcome To: \(country.name)")
        Button (action: {
            router.reset()
        }){
            Text("Pop to root")
        }
    }
}

struct CountryCellView: View {
    var country: Country
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(country.name).font(.headline)
            Text("Population: \(country.population)")
            Text("Language: \(country.language)")
            Text("Flag: \(country.emoji)")
        }
    }
}

extension ContinentsView {
    func parseJSON() -> [Continent] {
        guard let path = Bundle.main.path(forResource: "Continents",
                                          ofType: "json") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            return try decoder.decode([Continent].self, from: data)
        } catch {
            print("Error parsing JSON: \(error)")
            return []
        }
    }
}

#Preview {
    ContinentsView().environmentObject(Router())
}
