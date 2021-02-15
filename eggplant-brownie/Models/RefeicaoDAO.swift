//
//  RefeicaoDAO.swift
//  eggplant-brownie
//
//  Created by Luiz Correa on 15/02/21.
//

import Foundation

class RefeicaoDAO {
    
    func recuperaCaminho() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return diretorio.appendingPathComponent("refeicao")
    }
    
    func save(_ refeicoes: [Refeicao]) {
        guard let caminho = recuperaCaminho() else {
            return
        }
        
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            
            try dados.write(to: caminho.absoluteURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func recupera() -> [Refeicao] {
        guard let caminho = recuperaCaminho() else {
            return []
        }
        
        do {
            let dados = try Data(contentsOf: caminho.absoluteURL)
            guard let refeicoesSalva = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else {
                return []
            }
            
            return refeicoesSalva
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
