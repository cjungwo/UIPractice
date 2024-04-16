//
//  ImageLoaderView.swift
//  UIPractice
//
//  Created by JungWoo Choi on 11/4/2024.
//

import SDWebImageSwiftUI
import SwiftUI

struct ImageLoaderView: View {
  var urlString: String = Constants.randomImage
  var resizingMode: ContentMode = .fill

  var body: some View {
    Rectangle()
      .opacity(0.001)
      .overlay(
        WebImage(url: URL(string: urlString))
          .resizable()
          .indicator(.activity)
          .aspectRatio(contentMode: resizingMode)
          .allowsHitTesting(false)
      )
      .clipped()
  }
}

#Preview {
  ImageLoaderView()
    .clipShape(RoundedRectangle(cornerRadius: 30))
    .padding(40)
    .padding(.vertical, 60)
}
