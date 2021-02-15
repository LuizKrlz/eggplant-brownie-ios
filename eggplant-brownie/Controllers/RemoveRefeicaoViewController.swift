//
//  RemoveRefeicaoViewController.swift
//  eggplant-brownie
//
//  Created by Luiz Correa on 15/02/21.
//

import UIKit

class RemoveRefeicaoViewController {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    // toda vez que eu quiser repassar uma closure de volta eu preciso utilizar o @scaping
    func exibe(_ refeicao: Refeicao, handler: @escaping (UIAlertAction) -> Void) {
        let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        let btnCancelar = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alerta.addAction(btnCancelar)
        
        func removeRefeicao(alertAction: UIAlertAction) {
            print("Remover refeicao")
            
        }
        
        // btn with handler closure
        let botaoRemover =  UIAlertAction(title: "remover", style: .destructive, handler: handler)
        
        alerta.addAction(botaoRemover)
        
        controller.present(alerta, animated: true, completion: nil)
    }
}
