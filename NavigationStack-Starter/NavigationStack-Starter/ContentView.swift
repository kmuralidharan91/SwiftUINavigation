//
//  ContentView.swift
//  NavigationView
//
//  Created by Muralidharan Kathiresan on 18/05/24.
//

import SwiftUI

struct ContinentsView: View {
    @State private var continents: Continents = []
    @State var isActive : Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                List(continents) { continent in
                    NavigationLink(
                        destination: CountriesListView(continent: continent, isRootViewActive: $isActive),
                        isActive: $isActive
                    ) {
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
    var continent: Continent
    @Binding var isRootViewActive : Bool
    
    init(continent: Continent, isRootViewActive: Binding<Bool>) {
        self.continent = continent
        self._isRootViewActive = isRootViewActive
        print("Creating Countries ListView for \(continent.name)")
    }

    var body: some View {
        List(continent.countries) { country in
            NavigationLink(destination: CountryDetailView(country: country, shouldPopToRootView: $isRootViewActive)) {
                CountryCellView(country: country)
            }
        }
        .navigationTitle("Countries")
    }
}

struct CountryDetailView: View {
    var country: Country
    @Binding var shouldPopToRootView : Bool
    
    init(country: Country, shouldPopToRootView: Binding<Bool>) {
        self.country = country
        self._shouldPopToRootView = shouldPopToRootView
        print("Creating Detail View for \(country.name)")
    }
    
    var body: some View {
        Text("Hi Welcome To: \(country.name)")
        Button (action: {
            shouldPopToRootView = false
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
