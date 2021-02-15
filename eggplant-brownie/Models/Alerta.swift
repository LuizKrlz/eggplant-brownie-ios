//
//  Alerta.swift
//  eggplant-brownie
//
//  Created by Luiz Correa on 12/02/21.
//

import UIKit

class Alerta {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(title: String = "Atenção", mensagem: String = "Oops, aconteceu algo de errado") {
        let alerta = UIAlertController(title: title, message: mensagem, preferredStyle: .alert)
        
        let btnOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alerta.addAction(btnOK)
        
        self.controller.present(alerta, animated: true, completion: nil)
    }
}
