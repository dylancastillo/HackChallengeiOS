//
//  Event.swift
//  fratapp
//
//  Created by Dylan Castillo on 5/5/23.
//

import Foundation

struct Event: Codable {
    var id: Int
    var name: String
    var description: String
    var start_date: String
    var end_date: String
    var is_public: Bool
    var location: String
    var hosting_fraternities: [Fraternity]
    var invitations: [Invitation]
}

struct EventResponse: Codable {
    var events: [Event]
}
