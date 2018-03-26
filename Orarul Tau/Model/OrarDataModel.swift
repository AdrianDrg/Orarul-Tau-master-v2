//
//  OrarData.swift
//  Orarul Tau
//
//  Created by Draghici Adrian on 14/03/2018.
//  Copyright © 2018 Draghici Adrian. All rights reserved.
//

import Foundation

class OrarData {
    
    var ziMaterie : String
    var codSala : String
    var materie : String
    var profesor : String
    var tip : String
    var intervalOrar : String

    init(zi : String, cod : String, Materie : String, Profesor : String, Tip : String, intervalOra : String) {
        
        codSala = cod
        materie = Materie
        profesor = Profesor
        tip = Tip
        ziMaterie = zi
        intervalOrar = intervalOra
    }
    
}
