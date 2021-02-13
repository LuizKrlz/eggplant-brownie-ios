//
//  Refeicao.swift
//  eggplant-brownie
//
//  Created by Luiz Correa on 05/02/21.
//

import UIKit

class Refeicao: NSObject {
    let nome: String
    let felicidade: Int
    var itens: Array<Item> = []
    
    init(nome: String, felicidade: Int, itens: [Item] = []) {
        self.nome = nome
        self.felicidade = felicidade
        self.itens = itens
    }
    
    func totalDeCalorias() -> Double {
        var total = 0.0
        
        for item in itens {
            total += item.calorias
        }
        
        return total
    }
    
    
    /// Detalhes
    /// - Returns: Create a message with detalils
    func detalhes() -> String {
        // alerta padrao do ios
        var mensagem = "Felicidade: \(self.felicidade)"
        
        for item in self.itens {
            mensagem += ", \(item.nome) - calorias: \(item.calorias)"
        }
        
        return mensagem
    }
}

