//
//  CheckIn.swift
//  Events
//
//  Created by arthur.giachini on 03/03/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

import Foundation

struct CheckIn: Decodable {
    var eventId: String
    var name: String
    var email: String
    
    func toJSON() -> [String: String] {
        return [
            "eventId": eventId,
            "name": name,
            "email": email
        ]
    }
}
