//
//  ContentView.swift
//  NavigationView
//
//  Created by Muralidharan Kathiresan on 18/05/24.
//

import SwiftUI

struct ContinentsView: View {
    @State private var continents: Continents = []
    
    var body: some View {
        NavigationView {
            VStack {
                List(continents) { continent in
                    NavigationLink(
                        destination: CountriesListView(continent: continent)) {
                        Text(continent.name)
                    }
                }
                .onAppear { continents = parseJSON() }
                .navigationTitle("Continents")
            }
        }
    }
}

struct CountriesListView: View {
    var countries: [Country]
    
    init(continent: Continent) {
        self.countries = continent.countries
    }

    var body: some View {
        List(countries) { country in
            NavigationLink(destination: CountryDetailView(country: country)) {
                CountryCellView(country: country)
            }
        }
        .navigationTitle("Countries")
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

struct CountryDetailView: View {
    var country: Country
    
    var body: some View {
        Text("Hi Welcome To: \(country.name)")
        Button (action: {

        }){
            Text("Pop to root")
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
