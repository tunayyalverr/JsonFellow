//
//  UserModel.swift
//  Tutorial
//
//  Created by Alver, Tunay on 30.10.2022.
//

import Foundation

struct User: Codable {
    var userID: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var pictureURL: URL?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case pictureURL = "pictureUrl"
        case firstName, lastName, email
    }
}
