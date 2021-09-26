//
//  DogImage.swift
//  BestDogs
//
//  Created by Tim Windsor Brown on 21/09/2021.
//

import Foundation

/*
 "image": {
   "height": 1199,
   "id": "BJa4kxc4X",
   "url": "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg",
   "width": 1600
 },
 */

struct DogImage:Codable {
    var height:Int
    var id:String
    var url:String
    var width:Int
    
}
