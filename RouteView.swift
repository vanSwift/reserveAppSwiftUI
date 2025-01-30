//
//  RouteView.swift
//  reserveAppSwiftUI
//
//  Created by Иван Терехов on 28.01.2025.
//

import Foundation
import SwiftUI

struct RouteView: View {
    @State var observed : Observed = .init()
    var body: some View {
        
        if observed.appState == .authorized{
            HomeView().background(.main)
        }
        else{
            AuthPage(routeObserved: observed)
        }
    }
}

extension RouteView {
    @Observable class Observed{
        var appState: AppState = .unauthorized
    }
}

enum AppState{
    case authorized
    case unauthorized
}

#Preview{
    RouteView()
}
