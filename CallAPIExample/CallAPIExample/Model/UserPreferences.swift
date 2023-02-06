//
//  UserPreferences.swift
//  CallAPIExample
//
//  Created by imac-1681 on 2023/2/6.
//

import Foundation
class UserPreferences: NSObject {
    static let shared = UserPreferences()
    enum Keys: String {
        case lastSearchNum
        case county
        case aqi
        case status
    }
    var lastSearchNum: String {
        get { return UserDefaults.standard.string(forKey: Keys.lastSearchNum.rawValue) ?? ""}
        set { UserDefaults.standard.set(newValue, forKey: Keys.lastSearchNum.rawValue)}
    }

    var aqi: String {
        get { return UserDefaults.standard.string(forKey: Keys.aqi.rawValue) ?? ""}
        set { UserDefaults.standard.set(newValue, forKey: Keys.aqi.rawValue)}
    }
    
    var county: String {
        get { return UserDefaults.standard.string(forKey: Keys.county.rawValue) ?? ""}
        set { UserDefaults.standard.set(newValue, forKey: Keys.county.rawValue)}
    }
    
    var status: String {
        get { return UserDefaults.standard.string(forKey: Keys.status.rawValue) ?? ""}
        set { UserDefaults.standard.set(newValue, forKey: Keys.status.rawValue)}
    }
}
