

import Foundation
import Alamofire
import SwiftyJSON


func getWebservice(url: String, completion: @escaping (JSON?, AFError?) -> Void) {
    AF.request(url, method: .get) {
        $0.timeoutInterval = 10
    }
    .responseJSON { response in
        
        // print("response", response)
        
        switch response.result {
        
        case let .success(value):do {
            //print("successed", value)
            
            let res: JSON = JSON(value)
            
            completion(res, nil)
            
        }
        
        case let .failure(error): do {
            print("failed")
            
            completion(nil, error)
            
        }
        
        }
        
    }
}
