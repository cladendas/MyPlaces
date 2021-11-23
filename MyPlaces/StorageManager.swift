//
//  StorageManager.swift
//  MyPlaces
//
//  Created by cladendas on 20.11.2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ place: Place) {
        ///запись в БД
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func deleteObject(_ place: Place) {
        ///удаление из БД
        try! realm.write {
            realm.delete(place)
        }
    }
}
