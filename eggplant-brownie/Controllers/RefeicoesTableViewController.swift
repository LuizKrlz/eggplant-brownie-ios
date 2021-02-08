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
        
        return cell
    }
    
    func add(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
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
