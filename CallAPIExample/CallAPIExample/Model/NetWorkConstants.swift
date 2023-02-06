//
//  NetWorkConstants.swift
//  CallAPIExample
//
//  Created by imac-1681 on 2023/2/3.
//

import Foundation

struct NetWorkConstants{
    static let apikey = "fabdbbbb-0602-4c42-88fe-ddaf7502c4ed"
    static let baseUrl = "https://"
    enum APIPath: String {
        case api = "data.epa.gov.tw/api/v2/aqx_p_432?"
    }
    
    enum ResquesError: Error {
        //無料的URL
        case invalidURL
        //未知的錯誤
        case unknowError(Error)
        //無效的Response
        case invalidResponse
        //JSON解碼失敗
        case jsonDecodeFailed
        
        
    }
}

typealias AQIResponseResult<D: Decodable> = Result<D,NetWorkConstants.ResquesError>
