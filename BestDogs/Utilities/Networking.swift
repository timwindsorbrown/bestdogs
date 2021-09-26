//
//  Networking.swift
//  BestDogs
//
//  Created by Tim Windsor Brown on 21/09/2021.
//

import Foundation
import Alamofire
import UIKit

public struct Networking {
    
    private static let apiKey:String = "a37cf724-066d-49c8-9b5d-d2a3d81e6526"
    let headers: HTTPHeaders = [
//        "Authorization": "Basic VXNlcm5hbWU6UGFzc3dvcmQ=",
        "Accept": "application/json",
        "x-api-key":apiKey
    ]
    
    
    func searchBreeds(query:String, completion:@escaping (AFResult<[Breed]>)->()) {
        let parameters:Parameters = ["q":query]
        AF.request("https://api.thedogapi.com/v1/breeds/search", parameters: parameters, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                debugPrint(data ?? "No data")
                
                if let data = data,
                   let breeds = Breed.decodeBreeds(data: data) {
                    completion(.success(breeds))
                }
                else {
                    // Empty data
                    completion(.success([]))
                }

            case .failure(let error):
                debugPrint(error)
                completion(.failure(error))
            }
        }
    }
    
    func fetchImage(imageRef ref:String, completion:@escaping((AFResult<UIImage>)->())) {
        let imageURL = "https://cdn2.thedogapi.com/images/\(ref).jpg"
        AF.request(imageURL, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data,
                   let image = UIImage(data: data, scale: 1) {
                    completion(.success(image))
                }
                else {
                    completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                }
                
            case .failure(let error):
                debugPrint(error)
                completion(.failure(error))
            }
        }
    }
    
//    func decodeBreeds(data:Data) -> [Breed]? {
//        do {
//            let decoder = JSONDecoder()
//               if let breeds = try? decoder.decode(Array<Breed>.self, from: data) {
//                return breeds
//            }
//            else {
//                return
//            }
//        }
//        catch let error {
//            debugPrint("Error: " + error)
//        }
//    }
    
}
