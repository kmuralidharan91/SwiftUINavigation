//
//  ContentView.swift
//  NavigationView
//
//  Created by Muralidharan Kathiresan on 18/05/24.
//

import SwiftUI

struct ContinentsView: View {
    @State private var continents: Continents = []
    @State private var navPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navPath) {
            VStack {
                List(continents) { continent in
                    NavigationLink(value: continent) {
                        Text(continent.name)
                    }
                }
                .onAppear { continents = parseJSON() }
                .navigationTitle("Continents")
            }.navigationDestination(for: Continent.self) { continent in
                CountriesListView(continent: continent, navPath: $navPath)
            }
        }
    }
}

struct CountriesListView: View {
    var continent: Continent
    @Binding var navPath: NavigationPath
    
    init(continent: Continent, navPath: Binding<NavigationPath>) {
        self.continent = continent
        self._navPath = navPath
        print("Creating Countries ListView for \(continent.name)")
    }

    var body: some View {
        List(continent.countries) { country in
            NavigationLink(value: country) {
                CountryCellView(country: country)
            }
        }
        .navigationDestination(for: Country.self) { country in
            CountryDetailView(country: country, navPath: $navPath)
        }
        .navigationTitle("Countries")
    }
}

struct CountryDetailView: View {
    var country: Country
    @Binding var navPath: NavigationPath

    init(country: Country, navPath: Binding<NavigationPath>) {
        self.country = country
        self._navPath = navPath
        print("Creating Detail View for \(country.name)")
    }
    
    var body: some View {
        Text("Hi Welcome To: \(country.name)")
        Button (action: {
            navPath = NavigationPath()
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
    ContinentsView()
}
