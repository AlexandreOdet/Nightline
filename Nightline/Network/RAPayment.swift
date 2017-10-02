//
//  RAPayment.swift
//  Nightline
//
//  Created by Odet Alexandre on 14/09/2017.
//  Copyright © 2017 Odet Alexandre. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

enum sendCardInfoReturn {
    case success()
    case error(e: Error?)
}

class RAPayment: RABase {
    func sendCardInfos(creditCardToken: String, user: User,
                       callback: @escaping (sendCardInfoReturn) -> Void) {
        let url = RoutesAPI.payment.url
        var parameters: [String:Any] = ["token":creditCardToken]
        parameters["user"] = user.toJSON()
        request = Alamofire.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(_):
                    callback(.success())
                case .failure(_):
                    callback(.error(e: response.error))
                }
            })
    }
}
