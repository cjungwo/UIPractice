//
//  SongRowCell.swift
//  UIPractice
//
//  Created by JungWoo Choi on 15/4/2024.
//

import SwiftUI

struct SongRowCell: View {
  var imageSize: CGFloat = 50
  var imageName: String = Constants.randomImage
  var title: String = "Some sone name goes here"
  var subtitle: String? = "Some artist name"
  var onCellTapped: (() -> Void)? = nil
  var onEllipsisBtnTapped: (() -> Void)? = nil

  var body: some View {
    HStack(spacing: 8) {
      ImageLoaderView(urlString: imageName)
        .frame(width: imageSize, height: imageSize)
      
      VStack(alignment: .leading, spacing: 4) {
        Text(title)
          .font(.body)
          .fontWeight(.medium)
          .foregroundStyle(.spotifyWhite)
        
        if let subtitle {
          Text(subtitle)
            .font(.callout)
            .foregroundStyle(.spotifyLightGray)
        }
      }
      .lineLimit(2)
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Image(systemName: "ellipsis")
        .font(.subheadline)
        .foregroundStyle(.spotifyWhite)
        .padding(16)
        .background(.black.opacity(0.001))
        .onTapGesture {
          onEllipsisBtnTapped?()
        }
    }
    .onTapGesture {
      onCellTapped?()
    }
  }
}

#Preview {
  ZStack {
    Color.spotifyBlack.ignoresSafeArea()
    
    VStack {
      SongRowCell()
      SongRowCell()
      SongRowCell()
      SongRowCell()
    }
  }
}
