//
//  AQI.swift
//  CallAPIExample
//
//  Created by imac-1681 on 2023/2/3.
//

import Foundation

struct AQIResponse : Decodable{
    
//    let fields : [Fields]
    let records : [Records]
    struct Records : Decodable{
        let county : String
        let aqi : String
        let status : String
    }
}
struct Fields : Decodable{
    let id : String
    let type : String
    let info : Info
}
struct Info : Decodable{
    let label : String
}

