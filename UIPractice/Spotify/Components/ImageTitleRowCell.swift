//
//  ImageTitleRowCell.swift
//  UIPractice
//
//  Created by JungWoo Choi on 13/4/2024.
//

import SwiftUI

struct ImageTitleRowCell: View {
  
  var imageSize: CGFloat = 100
  var imageName: String = Constants.randomImage
  var title: String = "Sample title title title title title title"
  
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
        ImageLoaderView(urlString: imageName)
          .frame(width: imageSize, height: imageSize)
        
        Text(title)
          .font(.callout)
          .foregroundStyle(.spotifyLightGray)
          .lineLimit(2)
          .padding(4)
      }
      .frame(width: imageSize)
    }
}

#Preview {
    ImageTitleRowCell()
}
