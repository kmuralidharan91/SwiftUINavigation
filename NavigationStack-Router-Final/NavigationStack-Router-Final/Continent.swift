//
//  Continent.swift
//  NavigationView
//
//  Created by Muralidharan Kathiresan on 18/05/24.
//

import Foundation

// MARK: - Continent
struct Continent: Codable, Identifiable, Hashable {
    let continent: String
    let countries: [Country]
    
    var id: UUID {
        return UUID()
    }
    
    var name: String {
        return continent
    }
}

// MARK: - Country
struct Country: Codable, Identifiable, Hashable {
    let name, emoji, population, language: String
    
    var id: UUID {
        return UUID()
    }
}

extension Country {
    static func generateCountryObject(from name: String) -> Country {
        return Country(name: name.capitalized, emoji: "😀", population: "100", language: "Lang")
    }
}

typealias Continents = [Continent]
typealias Countries = [Country]
