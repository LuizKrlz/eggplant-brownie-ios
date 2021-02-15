//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by Luiz Correa on 08/02/21.
//

import UIKit

class RefeicoesTableViewController: UITableViewController, AdicionaRefeicaoDelegate {
    // MARK: - Atributos
    var refeicoes: [Refeicao] = []
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        refeicoes = RefeicaoDAO().recupera()
    }
    
    // MARK: - TableView
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
    
    // MARK: - Metodos
    
    func add(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
        RefeicaoDAO().save(refeicoes)
    }
    
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let celula = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: celula) else { return }
            let refeicao = refeicoes[indexPath.row] 
            
            RemoveRefeicaoViewController(controller: self).exibe(refeicao, handler: { alerta in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
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
