//
//  PlaylistDescriptionCell.swift
//  UIPractice
//
//  Created by JungWoo Choi on 15/4/2024.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
  var descriptionText: String = Product.mock.description
  var userName: String = "Nick"
  var subheadline: String = "Some headline goes here"
  var onAddToPlaylistBtnTapped: (() -> Void)? = nil
  var onDownloadBtnTapped: (() -> Void)? = nil
  var onShareBtnTapped: (() -> Void)? = nil
  var onEllipsisBtnTapped: (() -> Void)? = nil
  var onShuffleBtnTapped: (() -> Void)? = nil
  var onPlayBtnTapped: (() -> Void)? = nil

    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
        Text(descriptionText)
          .frame(maxWidth: .infinity, alignment: .leading)
        
        madeForYouSection
        
        Text(subheadline)
        
        btnsRow
        
      }
      .font(.callout)
      .fontWeight(.medium)
      .foregroundStyle(.spotifyLightGray)
    }
  
  private var madeForYouSection: some View {
    HStack(spacing: 8) {
      Image(systemName: "applelogo")
        .font(.title3)
        .foregroundStyle(.spotifyGreen)
      
      Text("Made for ")
      +
      Text(userName)
        .bold()
        .foregroundStyle(.spotifyWhite)
    }
  }
  
  private var btnsRow: some View {
    HStack(spacing: 0) {
      HStack(spacing: 0) {
        Image(systemName: "plus.circle")
          .padding(8)
          .onTapGesture {
            //
          }
        
        Image(systemName: "arrow.down.circle")
          .padding(8)
          .onTapGesture {
            //
          }
        
        Image(systemName: "square.and.arrow.up")
          .padding(8)
          .onTapGesture {
            //
          }
        
        Image(systemName: "ellipsis")
          .padding(8)
          .onTapGesture {
            //
          }
      }
      .offset(x: -8)
      .frame(maxWidth: .infinity, alignment: .leading)
      
      HStack(spacing: 8) {
        Image(systemName: "shuffle")
          .font(.system(size: 24))
          .background(.black.opacity(0.001))
          .onTapGesture {
            //
          }
        
        Image(systemName: "play.circle.fill")
          .font(.system(size: 46))
          .background(.black.opacity(0.001))
          .onTapGesture {
            //
          }
      }
      .foregroundStyle(.spotifyGreen)
    }
    .font(.title2)
  }
}

#Preview {
    ZStack {
      Color.black.ignoresSafeArea()
      
      PlaylistDescriptionCell()
        .padding()
    }
}
