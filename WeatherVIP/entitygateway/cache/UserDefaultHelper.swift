//
//  UserDefaultHelper.swift
//  WeatherVIP
//
//  Created by Olorunshola Godwin on 27/09/2020.
//  Copyright © 2020 Olorunshola Godwin. All rights reserved.
//

import Foundation

struct UserDefaultHelper {
    func save<T: Encodable>(_ object: T, key: UserDefaults.Keys) {
        if let encodedUser = try? JSONEncoder().encode(object) {
            key.setValue(encodedUser)
        }
    }

    func get<T: Decodable>(key: UserDefaults.Keys) -> T? {
        if let data = key.dataValue, let object = try? JSONDecoder().decode(T.self, from: data) {
            return object
        }
        return nil
    }

}

extension UserDefaults {
    enum Keys: String {
        case currentDayForecast = "CurrentDayForecast"
        case comingDaysForecast = "ComingDaysForecast"

        func setValue(_ value: Any?) {
            guard let value = value else {
                return
            }
            let uds = UserDefaults.standard
            uds.set(value, forKey: self.rawValue)
        }

        var dataValue: Data? {
            let uds = UserDefaults.standard
            return uds.data(forKey: self.rawValue)
        }
    }
}
