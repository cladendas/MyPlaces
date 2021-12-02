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
    @objc dynamic var date = Date()
    @objc dynamic var rating = Double()

    //назначенный инициализатор
    convenience init(name: String, location: String?, type: String?, imageData: Data?, rating: Double) {
        //инициализирует св-ва значениями по умолчанию
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
        self.rating = rating
    }
}
