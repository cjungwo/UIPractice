//
//  User.swift
//  UIPractice
//
//  Created by JungWoo Choi on 11/4/2024.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Int
    let weight: Double
  
  static var mock: User {
    User(
      id: 101,
      firstName: "Chris",
      lastName: "Choi",
      age: 25,
      email: "example@email.com",
      phone: "0400000000",
      username: "cjungwo",
      password: "1234",
      image: Constants.randomImage,
      height: 170,
      weight: 55
    )
  }
}
