//
//  HomeView.swift
//  UIPractice
//
//  Created by JungWoo Choi on 11/4/2024.
//

import SwiftUI
import SwiftfulUI

struct SpotifyHomeView: View {
  
  @State private var currentUser: User? = nil
  @State private var selectedCategory: Category? = nil
  @State private var products: [Product] = []

  var body: some View {
    ZStack {
      Color.spotifyBlack
        .ignoresSafeArea()
      
      ScrollView(.vertical) {
        LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
          Section {
            VStack {
              recentsSection
              
              if let product = products.first {
                SpotifyNewReleaseCell(
                  imageName: product.firstImage,
                  headline: product.brand,
                  subheadline: product.category,
                  title: product.title,
                  subtitle: product.description,
                  onAddToPlaylistPressed: {
                    
                  },
                  onPlayPressed: {
                    
                  }
                )
              }
            }
            .padding(.horizontal, 16)
            
            ForEach(0..<10) { _ in
                Rectangle()
                .frame(width: 200, height: 200)
            }
          } header: {
            header
          }
        }
        .padding(.top, 8)
      }
      .scrollIndicators(.hidden)
      .clipped()
    }
    .task {
      await getData()
    }
  }
  
  private func getData() async {
    do {
      currentUser = try await DatabaseHelper().getUsers().first
      products = try await Array(DatabaseHelper().getProducts().prefix(8))
    } catch {
      
    }
  }
  
  private var header: some View {
    HStack(spacing: 0) {
      ZStack {
        if let currentUser {
          ImageLoaderView(urlString: currentUser.image)
            .background(.spotifyWhite)
            .clipShape(Circle())
            .onTapGesture {
              //
            }
        }
      }
      .frame(width: 35, height: 35)
      
      ScrollView(.horizontal) {
        HStack(spacing: 8) {
          ForEach(Category.allCases, id: \.self) { category in
              SpotifyCategoryCell(
                title: category.rawValue.capitalized,
                isSelected: category == selectedCategory
              )
              .onTapGesture {
                selectedCategory = category
              }
          }
        }
        .padding(.horizontal, 16)
      }
      .scrollIndicators(.hidden)
    }
    .padding(.vertical, 24)
    .padding(.leading, 8)
    .frame(maxWidth: .infinity)
    .background(Color.spotifyBlack)
  }
  
  private var recentsSection: some View {
    NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
      if let product {
        SpotifyRecentsCell(imageName: product.firstImage, title: product.title)
      }
    }
  }
}

#Preview {
  SpotifyHomeView()
}
