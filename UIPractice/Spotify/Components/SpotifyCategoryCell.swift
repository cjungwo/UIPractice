//
//  CategoryCell.swift
//  UIPractice
//
//  Created by JungWoo Choi on 11/4/2024.
//

import SwiftUI

struct SpotifyCategoryCell: View {
  
  var title: String = "All"
  var isSelected: Bool = false
  
  var body: some View {
    Text(title)
      .font(.callout)
      .frame(minWidth: 35)
      .padding(.vertical, 8)
      .padding(.horizontal, 10)
      .themeColors(isSelected: isSelected)
      .clipShape(RoundedRectangle(cornerRadius: 16))
  }
}

extension View {
  func themeColors(isSelected: Bool) -> some View {
    self
      .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
      .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
  }
}

#Preview {
  ZStack {
    Color.black.ignoresSafeArea()
    
    SpotifyCategoryCell()
  }
}
