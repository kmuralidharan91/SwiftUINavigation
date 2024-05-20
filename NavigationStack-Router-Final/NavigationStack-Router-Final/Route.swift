//
//  Route.swift
//  NavigationStack-Router-Final
//
//  Created by Muralidharan Kathiresan on 19/05/24.
//

import SwiftUI

enum Route {
    case continent(Continent)
    case country(Country)
}

extension Route: View {
    var body: some View {
        switch self {
        case .continent(let continent):
            CountriesListView(countries: continent.countries)
        case .country(let country):
            CountryDetailView(country: country)
        }
    }
}

extension Route: Hashable {}
