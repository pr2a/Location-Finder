//
//  places.swift
//  lab6
//
//  Created by Priya Ganguly on 11/10/19.
//  Copyright © 2019 idk. All rights reserved.
//

import Foundation
import UIKit

class places {
    
    var places:[place] = []
    

    init(){
//        let p1 = place(pn: "template place name", plo: "long 1", pla: "lat 1")
//
//        places.append(p1)
    }
    
    func getCount() -> Int{
        print(places.count)
        return places.count
    }
    
    func getPlaceObject(item: Int) -> place {
        return places[item]
    }
    
    func removePlaceObject(item: Int){
        places.remove(at: item)
    }
    
    func addPlaceObject(name: String, image: String) -> place{
        //add berkeley
        let p = place(pn: name, plo: "new place", pla: "place.jpg")
        places.append(p)
        return p
    }
}

class place {
    var placeName: String?
    var placeLongitude: String?
    var placeLatitude: String
    
    init(pn: String, plo: String, pla: String){
        placeName = pn
        placeLongitude = plo
        placeLatitude = pla
    }
}
