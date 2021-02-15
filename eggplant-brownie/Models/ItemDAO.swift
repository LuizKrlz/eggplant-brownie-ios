//
//  ItemDAO.swift
//  eggplant-brownie
//
//  Created by Luiz Correa on 15/02/21.
//

import Foundation

class ItemDAO {
    
    func recuperaUrl(path: String) -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return diretorio.appendingPathComponent(path)
    }
    
    func save(_ itens: [Item]) {
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            
            guard let caminho = recuperaUrl(path: "itens") else {
                return
            }
            
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recupera() -> [Item] {
        guard let caminho = recuperaUrl(path: "itens") else { return [] }
        
        do {
            let dados = try Data(contentsOf: caminho)
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as! Array<Item>
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
