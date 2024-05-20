//
//  NavigationStack_Router_FinalApp.swift
//  NavigationStack-Router-Final
//
//  Created by Muralidharan Kathiresan on 19/05/24.
//

import SwiftUI

@main
struct NavigationStack_Router_FinalApp: App {
    @StateObject private var router = Router()

    var body: some Scene {
        WindowGroup {
            ContinentsView()
                .environmentObject(router)
                .onOpenURL(perform: { url in
                    router.reset()
                    router.push(
                        to: Route.country(
                            Country.generateCountryObject(from: url.lastPathComponent)
                        )
                    )
                })
        }
    }
}

extension Country {
    static func generateCountryObject(from name: String) -> Country {
        return Country(name: name.capitalized, emoji: "😀", population: "100", language: "Lang")
    }
}
