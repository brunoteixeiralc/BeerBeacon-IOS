//
//  Taps.swift
//  BeerBeacon
//
//  Created by Bruno Corrêa on 07/04/17.
//  Copyright © 2017 Bruno Lemgruber. All rights reserved.
//

import Foundation
import Firebase

class Tap {
    
    var abv = ""
    var ibu = 0
    var cerveja = ""
    var cervejaria = ""
    var estilo = ""
    var nota = ""
   
    
    private let tapRef = FIRDatabase.database().reference().child("taps")
    
    init(abv:String,ibu:Int,cerveja:String,cervejaria:String,estilo:String,nota:String) {
        self.abv = abv
        self.ibu = ibu
        self.cerveja = cerveja
        self.cervejaria = cervejaria
        self.estilo = estilo
        self.nota = nota
    }
    
    init(snapshot: FIRDataSnapshot)
    {
        
        if let value = snapshot.value as? [String : Any] {
            abv = value["ABV"] as! String
            ibu = value["IBU"] as! Int
            cerveja = value["cerveja"] as! String
            cervejaria = value["cervejaria"] as! String
            estilo = value["estilo"] as! String
            nota = value["nota"] as! String
        }
    }
    
}


