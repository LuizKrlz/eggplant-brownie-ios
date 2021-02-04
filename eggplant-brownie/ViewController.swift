//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Luiz Correa on 28/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var nomeTextField: UITextField!
    @IBOutlet var felicidadeTextField: UITextField!
    
    @IBAction func adicionar() {
        let nome: String = "Costela"
        let felicidade: String = "5"
        print("comi \(nome) e fiquei com felicidade: \(felicidade)")
    }
}

