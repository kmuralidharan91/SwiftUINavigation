//
//  Router.swift
//  NavigationStack-Router-Final
//
//  Created by Muralidharan Kathiresan on 19/05/24.
//

import Foundation

final class Router: ObservableObject {
    @Published var routes = [Route]()
    
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
