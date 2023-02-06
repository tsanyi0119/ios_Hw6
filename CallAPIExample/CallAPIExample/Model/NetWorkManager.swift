//
//  NetWorkManager.swift
//  CallAPIExample
//
//  Created by imac-1681 on 2023/2/3.
//

import Foundation

class NetWorkManager: NSObject {
    static let shared = NetWorkManager()
    
    //請求網路資料
    func requestData<D: Decodable>(offset: Int = 0, limit: Int, finish: @escaping (AQIResponseResult<D>) -> Void) {
        //https://data.epa.gov.tw/api/v2/aqx_p_432?limit=10&api_key=fabdbbbb-0602-4c42-88fe-ddaf7502c4ed
        let path = NetWorkConstants.baseUrl + NetWorkConstants.APIPath.api.rawValue
        let apikey = NetWorkConstants.apikey
        guard let url = URL(string: path + "offset=\(offset)" + "&limit=\(limit)" + "&api_key=" + apikey) else {
            finish(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url){ data,response,error in
            //確認有無錯誤
            guard error == nil else{
                finish(.failure(.unknowError(error!)))
                return
            }
            
            //確認 statusCode 是否為200
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                finish(.failure(.invalidResponse))
                return
            }
            
            //確認是否成功用JOSNDecoder 解碼成我們要的結構
            let decoder = JSONDecoder()
            guard let data = data,
                  let results = try? decoder.decode(D.self, from: data) else {
                finish(.failure(.jsonDecodeFailed))
                return
            }
            //都成功後，將解碼完的資料通過閉包（closure）帶出來
            finish(.success(results))
        }.resume()
    }
}
