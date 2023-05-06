//
//  Fraternity.swift
//  fratapp
//
//  Created by Dylan Castillo on 5/5/23.
//

import Foundation

struct Fraternity: Codable {
    var id: Int
    var name: String
    var description: String
    var members: [User]?
    var subscribers: [User]?
    var events: [Event]?
}

struct FraternityResponse: Codable {
    var fraternities: [Fraternity]
}
