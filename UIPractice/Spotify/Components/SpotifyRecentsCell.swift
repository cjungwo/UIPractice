//
//  SpotifyRecentsCell.swift
//  UIPractice
//
//  Created by JungWoo Choi on 11/4/2024.
//

import SwiftUI

struct SpotifyRecentsCell: View {
  
  var imageName: String = Constants.randomImage
  var title: String = "Some title"
  
  var body: some View {
    HStack(spacing: 16) {
      ImageLoaderView(urlString: imageName)
        .frame(width: 55, height: 55)
      
      Text(title)
        .font(.callout)
        .fontWeight(.semibold)
        .lineLimit(2)
    }
    .padding(.trailing, 8)
    .frame(maxWidth: .infinity, alignment: .leading)
    .themeColors(isSelected: false)
    .clipShape(RoundedRectangle(cornerRadius: 6))
  }
}

#Preview {
  ZStack {
    Color.black.ignoresSafeArea()
    
    VStack {
      HStack {
        SpotifyRecentsCell()
        SpotifyRecentsCell()
      }
      
      HStack {
        SpotifyRecentsCell()
        SpotifyRecentsCell()
      }
    }
  }
}
