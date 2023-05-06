//
//  Invitation.swift
//  fratapp
//
//  Created by Dylan Castillo on 5/5/23.
//

import Foundation

struct Invitation: Codable {
    var id: Int
    var sender_id: Int
    var receiver_id: Int
    var event_id: Int
    var fraternity_id: Int
    var is_accepted: Bool?
}

struct InvitationResponse: Codable {
    var invitations: [Invitation]
}
