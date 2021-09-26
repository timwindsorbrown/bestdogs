//
//  Breed.swift
//  BestDogs
//
//  Created by Tim Windsor Brown on 21/09/2021.
//

import Foundation

/*
 
 [
   {
     "bred_for": "Small rodent hunting, lapdog",
     "breed_group": "Toy",
     "height": {
       "imperial": "9 - 11.5",
       "metric": "23 - 29"
     },
     "id": 1,
     "life_span": "10 - 12 years",
     "name": "Affenpinscher",
     "origin": "Germany, France",
     "reference_image_id": "BJa4kxc4X",
     "temperament": "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving",
     "weight": {
       "imperial": "6 - 13",
       "metric": "3 - 6"
     }
   }
 ]
 */


struct Breed: Codable {
    
    var bredFor:String?
    var breedGroup:String?
    // Picking the metric from the array
//    var height:Int
    var id:Int
    var imageRef:String?
    var lifeSpan:String?
    var name:String?
    var origin:String?
    var temperament:String?
    // Picking the metric from the array
//    var weight:Int
    
    enum CodingKeys: String, CodingKey {
        case imageRef = "reference_image_id"
        case lifeSpan = "life_span"
        case bredFor = "bred_for"
        
        case breedGroup, id, name,
             origin, temperament
    }
 
    static func decodeBreeds(data:Data) -> [Breed]? {
        
        let decoder = JSONDecoder()
        do {
            let breeds = try decoder.decode(Array<Breed>.self, from: data)
            return breeds
        }
        catch let error {
            debugPrint(error)
            return nil
        }
        
    }
    
    
}
