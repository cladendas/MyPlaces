//
//  Place.swift
//  MyPlaces
//
//  Created by cladendas on 03.11.2021.
//

import Foundation

struct Place {
    
    var name: String
    var location: String
    var type: String
    var image: String
    
    static var restaurantNames = [
        "Краснодарский парень", "БК на Красной возле Мира", "Subway в Доме книги", "ЦарьХлеб", "ChiChi", "PhoBo"
    ]
    
    static func getPlaces() -> [Place] {
        
        var places = [Place]()
        
        for place in restaurantNames {
            places.append(Place(name: place, location: "Краснодар", type: "Бар", image: place))
        }
        
        return places
    }
}
