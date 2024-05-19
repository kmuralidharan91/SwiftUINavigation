//
//  ContentView.swift
//  NavigationView
//
//  Created by Muralidharan Kathiresan on 18/05/24.
//

import SwiftUI

struct ContinentsView: View {
    @State private var visibility: NavigationSplitViewVisibility = .all
    @State private var continents: Continents = []
    @State private var selectedContinent: Continent? = nil
    @State private var selectedCountry: Country? = nil
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(continents, selection: $selectedContinent) { continent in
                NavigationLink(continent.name, value: continent)
            }.navigationTitle("Continents")
        } content: {
            CountriesListView(countries: selectedContinent?.countries ?? [],
                              selectedCountry: $selectedCountry)
        }
    detail: {
        if let country = selectedCountry {
            CountryDetailView(country: country)
        }
    }
    .onAppear { continents = parseJSON() }
    }
}

struct CountriesListView: View {
    var countries: [Country]
    @Binding private var selectedCountry: Country?
    
    init(countries: [Country], selectedCountry: Binding<Country?>) {
        self.countries = countries
        self._selectedCountry = selectedCountry
    }

    var body: some View {
        List(countries, selection: $selectedCountry) { country in
            NavigationLink(value: country) {
                CountryCellView(country: country)
            }
        }
        .navigationTitle("Countries")
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
