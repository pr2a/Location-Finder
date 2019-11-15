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
    
    init(){}
    
    func getCount() -> Int{
        print(places.count)
        return places.count
    }
    
    func getPlaceObject(item: Int) -> place {
        return places[item]
    }
    
    func removePlaceObject(item: Int) {
        places.remove(at: item)
    }
    
    func addPlaceObject(name: String, image: String) -> place {
        let p = place(pn: name)
        places.append(p)
        return p
    }
}

class place {
    var placeName: String?
    
    init(pn: String) {
        placeName = pn
    }
}
