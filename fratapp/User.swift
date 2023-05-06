//
//  User.swift
//  fratapp
//
//  Created by Dylan Castillo on 5/5/23.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
    var net_id: String
    var email: String
    var fraternity_memberships: [Fraternity]?
    var subscriptions: [Fraternity]?
}
