//
//  FoundationExtensions.swift
//  HackerBooks
//
//  Created by Fran Delgado on 5/2/17.
//  Copyright © 2017 Fran Delgado. All rights reserved.
//

import Foundation

extension Bundle {
    
    // Hacer vesión de esta función para que trabaje también con opcionales
    func url(forResource name: String) -> URL? {
        // Partir el nombre por el punto .
        // Investigar el name?
        let tokens = name.components(separatedBy: ".")
        
        // Comprobar aquí con un guard que hay dos componentes y todo es correcto
        
        // Si sale bien, crear la url
        return url(forResource: tokens[0], withExtension: tokens[1])
    }
}
