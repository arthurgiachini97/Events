//
//  Event.swift
//  Events
//
//  Created by arthur.giachini on 18/02/20.
//  Copyright © 2020 arthur.giachini. All rights reserved.
//

struct Event: Codable {
    var people: [Person]?
    var date: Int
    var description: String
    var image: String
    var longitude: Float
    var latitude: Float
    var price: Float
    var title: String
    var id: String
    var cupons: [Cupon]?
}
