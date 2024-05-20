//
//  Router.swift
//  NavigationStack-Router-Final
//
//  Created by Muralidharan Kathiresan on 19/05/24.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var routes = [Route]() {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPathStore")

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Route].self, from: data) {
                routes = decoded
                return
            }
        }
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(routes)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

extension Router {
    func push(to screen: Route) {
        guard !routes.contains(screen) else {
            return
        }
        routes.append(screen)
    }
    
    func goBack() {
        _ = routes.popLast()
    }
    
    func reset() {
        routes = []
    }
    
    func replace(stack: [Route]) {
        routes = stack
    }
}
