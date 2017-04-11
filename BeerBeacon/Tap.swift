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
    var torneira = ""
    var medidas = [Medida]()
   
    
    private let tapRef = FIRDatabase.database().reference().child("taps")
    
    init(abv:String,ibu:Int,cerveja:String,cervejaria:String,estilo:String,nota:String,torneira:String,medidas:[Medida]) {
        self.abv = abv
        self.ibu = ibu
        self.cerveja = cerveja
        self.cervejaria = cervejaria
        self.estilo = estilo
        self.nota = nota
        self.torneira = torneira
        self.medidas = medidas
    }
    
    init(snapshot: FIRDataSnapshot)
    {
        if let value = snapshot.value as? [String : Any] {
            torneira = snapshot.key
            abv = value["ABV"] as! String
            ibu = value["IBU"] as! Int
            cerveja = value["cerveja"] as! String
            cervejaria = value["cervejaria"] as! String
            estilo = value["estilo"] as! String
            nota = value["nota"] as! String
            let medidaSnap = snapshot.childSnapshot(forPath: "medidas").children
            while let m = medidaSnap.nextObject() as? FIRDataSnapshot {
                let med = Medida(preco: (m.value as? [String:Any])?["preco"] as! String, quantidade: (m.value as? [String:Any])?["quantidade"] as! String)
                medidas.append(med)
            }
        }
    }
    
}


