//
//  SpotifyPlaylistView.swift
//  UIPractice
//
//  Created by JungWoo Choi on 15/4/2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {
  var product: Product = .mock
  var user: User = .mock
  
  @Environment(\.router) var router
  
  @State private var products: [Product] = []
  @State private var showHeader: Bool = true
  @State private var offset: CGFloat = 0
  
    var body: some View {
      ZStack {
        Color.spotifyBlack.ignoresSafeArea()
        
        ScrollView(.vertical) {
          LazyVStack(spacing: 12) {
            PlaylistHeaderCell(
              height: 250,
              title: product.title,
              subtitle: product.brand,
              imageName: product.thumbnail
            )
            .readingFrame { frame in
              offset = frame.maxY
              showHeader = frame.maxY < 150 ? true : false
            }
            
            PlaylistDescriptionCell(
              descriptionText: product.description,
              userName: user.username,
              subheadline: product.category,
              onAddToPlaylistBtnTapped: nil,
              onDownloadBtnTapped: nil,
              onShareBtnTapped: nil,
              onEllipsisBtnTapped: nil,
              onShuffleBtnTapped: nil,
              onPlayBtnTapped: nil
            )
            .padding(.horizontal, 16)
            
            ForEach(products) { product in
                SongRowCell(
                  imageSize: 50,
                  imageName: product.firstImage,
                  title: product.title,
                  subtitle: product.brand,
                  onCellTapped: {
                    goToPlaylistView(product: product)
                  },
                  onEllipsisBtnTapped: {
                    //
                  }
                )
            }
          }
        }
        .scrollIndicators(.hidden)
        
        header
        .frame(maxHeight: .infinity, alignment: .top)
      }
      .task {
        await getData()
      }
      .toolbar(.hidden, for: .navigationBar)
    }
  
  private func getData() async {
    do {
      products = try await DatabaseHelper().getProducts()
    } catch {
      //
    }
  }
  
  private func goToPlaylistView(product: Product) {
    router.showScreen(.push) { _ in
      SpotifyPlaylistView(product: product, user: user)
    }
  }
  
  private var header: some View {
    ZStack {
      Text(product.title)
        .font(.headline)
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(.spotifyLightGray)
        .offset(y: showHeader ? 0 : -200)
        .opacity(showHeader ? 1 : 0)
      
      Image(systemName: "chevron.left")
        .font(.title3)
        .padding(10)
        .background(showHeader ? .black.opacity(0.001) : .spotifyGray.opacity(0.7))
        .clipShape(Circle())
        .onTapGesture {
          router.dismissScreen()
        }
        .padding(.leading, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .foregroundStyle(.spotifyWhite)
    .animation(.smooth(duration: 0.2), value: showHeader)
  }
}

#Preview {
    RouterView { _ in
      SpotifyPlaylistView()
    }
}
