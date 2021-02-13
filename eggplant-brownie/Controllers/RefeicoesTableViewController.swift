//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Luiz Correa on 08/02/21.
//

import UIKit

class RefeicoesTableViewController: UITableViewController, AdicionaRefeicaoDelegate {
    var refeicoes = [
        Refeicao(nome: "Feijoada", felicidade: 4),
        Refeicao(nome: "Churrasco", felicidade: 5),
        Refeicao(nome: "Quacamole", felicidade: 3)
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let refeicao = refeicoes[indexPath.row]
        cell.textLabel?.text = refeicao.nome
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
        
        cell.addGestureRecognizer(longPress)
        
        return cell
    }
    
    func add(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
    }
    
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let celula = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: celula) else { return }
            let refeicao = refeicoes[indexPath.row]
            
            
            refeicao.detalhes()
            
            let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
            let btnCancelar = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alerta.addAction(btnCancelar)
            
            present(alerta, animated: true, completion: nil)
        }
    }
    
    // parametros internos e externos uma palavra antes do real parametro a ser usado na funcao
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionar" {
            if let viewController = segue.destination as? ViewController {
                viewController.delegate = self
            }
        }
    }
}
