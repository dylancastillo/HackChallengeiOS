//
//  InviteAllotment.swift
//  fratapp
//
//  Created by Dylan Castillo on 5/5/23.
//

import Foundation

struct InviteAllotment: Codable {
    var user_id: Int
    var user_name: String
    var event_id: Int
    var num_invites: Int
    
}

//struct UserResponse: Codable {
//    var invite_allotments: [InviteAllotment]
//}
