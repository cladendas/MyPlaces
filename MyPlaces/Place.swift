//
//  Place.swift
//  MyPlaces
//
//  Created by cladendas on 03.11.2021.
//

import RealmSwift
import UIKit

//Для можели Realm нужен именно класс, наследуемый от Object
//Все св-ва класса объявляются @objc dynamic
class Place: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    
    var restaurantNames = [
        "Краснодарский парень", "БК на Красной возле Мира", "Subway в Доме книги", "ЦарьХлеб", "ChiChi", "PhoBo"
    ]
    
    func savePlaces() {

        for place in restaurantNames {
            
            let image = UIImage(named: place)
            guard let imageData = image?.pngData() else { return }
            
            let newPlace = Place()
            newPlace.name = place
            newPlace.location = "Krasnodar"
            newPlace.type = "Bar"
            newPlace.imageData = imageData
            
            StorageManager.saveObject(newPlace)
        }
        
    }
}
