//
//  ContentView.swift
//  UIPractice
//
//  Created by JungWoo Choi on 11/4/2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
  
  @Environment(\.router) var router
  
  var body: some View {
    List {
      Button("Open Spotify") {
        router.showScreen(.fullScreenCover) { _ in
          SpotifyHomeView(viewModel: SpotifyHomeViewModel(router: router))
        }
      }
    }
  }
}

#Preview {
  RouterView { _ in
    ContentView()
  }
}
