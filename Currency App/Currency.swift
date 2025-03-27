//
//  Currency.swift
//  Currency App
//
//  Created by Federico on 04/11/2021.
//

import Foundation
import Alamofire


struct Currency: Codable {
    var data = [String: Double]()
}

func apiRequest(url: String, completion: @escaping (Currency) -> ()) {
    
    Session.default.request(url).responseDecodable(of: Currency.self) { response in
        switch response.result {
        case .success(let currencies):
            print(currencies)
            completion(currencies)
        case .failure(let error):
            print(error)
        }
    }
}

