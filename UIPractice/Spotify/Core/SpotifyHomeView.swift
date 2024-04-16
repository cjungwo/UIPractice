//
//  HomeView.swift
//  UIPractice
//
//  Created by JungWoo Choi on 11/4/2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

@Observable
final class SpotifyHomeViewModel {
  let router: AnyRouter
  
  var currentUser: User? = nil
  var selectedCategory: Category? = nil
  var products: [Product] = []
  var productRows: [ProductRow] = []
  
  init(router: AnyRouter) {
    self.router = router
    self.currentUser = currentUser
    self.selectedCategory = selectedCategory
    self.products = products
    self.productRows = productRows
  }
  
  func getData() async {
    guard products.isEmpty else { return }
    
    do {
      currentUser = try await DatabaseHelper().getUsers().first
      products = try await Array(DatabaseHelper().getProducts().prefix(8))
      
      var rows: [ProductRow] = []
      let allBrands = Set(products.map({ $0.brand }))
      for brand in allBrands {
        let products = self.products.filter({ $0.brand == brand })
        rows.append(ProductRow(title: brand.capitalized, products: products))
      }
      productRows = rows
      
    } catch {
      //
    }
  }
  
  var header: some View {
    HStack(spacing: 0) {
      ZStack {
        if let currentUser {
          ImageLoaderView(urlString: currentUser.image)
            .background(.spotifyWhite)
            .clipShape(Circle())
            .onTapGesture {
              self.router.dismissScreen()
            }
        }
      }
      .frame(width: 35, height: 35)
      
      ScrollView(.horizontal) {
        HStack(spacing: 8) {
          ForEach(Category.allCases, id: \.self) { category in
              SpotifyCategoryCell(
                title: category.rawValue.capitalized,
                isSelected: category == self.selectedCategory
              )
              .onTapGesture {
                self.selectedCategory = category
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
  
  var recentsSection: some View {
    NonLazyVGrid(
      columns: 2,
      alignment: .center,
      spacing: 10,
      items: products
    ) { product in
      if let product {
        SpotifyRecentsCell(imageName: product.firstImage, title: product.title)
          .asButton(.press) {
            self.goToPlaylistView(product: product)
          }
      }
    }
  }
  
  func goToPlaylistView(product: Product) {
    guard let currentUser else { return }
    
    router.showScreen(.push) { _ in
      SpotifyPlaylistView(product: product, user: currentUser)
    }
  }
  
  func newReleaseSection(product: Product) -> some View {
    SpotifyNewReleaseCell(
      imageName: product.firstImage,
      headline: product.brand,
      subheadline: product.category,
      title: product.title,
      subtitle: product.description,
      onAddToPlaylistPressed: {
        
      },
      onPlayPressed: {
        self.goToPlaylistView(product: product)
      }
    )
  }
  
  var listRows: some View {
    ForEach(productRows) { row in
      VStack(alignment: .leading, spacing: 8) {
        Text(row.title)
          .font(.title)
          .fontWeight(.semibold)
          .foregroundStyle(.spotifyWhite)
          .frame(width: .infinity, alignment: .leading)
        
        ScrollView(.horizontal) {
          HStack(alignment: .top, spacing: 16) {
            ForEach(row.products) { product in
                ImageTitleRowCell(
                  imageSize: 120,
                  imageName: product.firstImage,
                  title: product.title
                )
                .asButton(.press) {
                  self.goToPlaylistView(product: product)
                }
            }
          }
          .padding(.horizontal, 16)
        }
        .scrollIndicators(.hidden)
      }
    }
  }
}

struct SpotifyHomeView: View {
  
  @State var viewModel: SpotifyHomeViewModel
  
  var body: some View {
    ZStack {
      Color.spotifyBlack
        .ignoresSafeArea()
      
      ScrollView(.vertical) {
        LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
          Section {
            VStack(spacing: 16) {
              viewModel.recentsSection
              
              if let product = viewModel.products.first {
                viewModel.newReleaseSection(product: product)
                  .padding(.horizontal, 16)
              }
              
              viewModel.listRows
            }
            .padding(.horizontal, 16)
            
          } header: {
            viewModel.header
          }
        }
        .padding(.top, 8)
      }
      .scrollIndicators(.hidden)
      .clipped()
    }
    .task {
      await viewModel.getData()
    }
  }
}

#Preview {
  RouterView { router in
    SpotifyHomeView(viewModel: SpotifyHomeViewModel(router: router))
  }
}
