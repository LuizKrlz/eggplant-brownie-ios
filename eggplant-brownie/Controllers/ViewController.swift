//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Luiz Correa on 28/01/21.
//

import UIKit

// equivale a interface
protocol AdicionaRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionaItensDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var itensTableView: UITableView!
    
    // MARK: - Atributos
    var delegate: AdicionaRefeicaoDelegate?
    var itens: [Item] = []
    
    var itensSelecionados: [Item] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        let btnAdicionaItem = UIBarButtonItem(title: "adicionar", style: .plain, target: self, action: #selector( adicionarItem))
        navigationItem.rightBarButtonItem = btnAdicionaItem
        itens = ItemDAO().recupera()
    }
    
    @objc func adicionarItem() {
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        ItemDAO().save(itens)
        if let tableView = itensTableView {
            tableView.reloadData()
        } else {
            let alerta = Alerta(controller: self)
            alerta.exibe(title: "Desculpe", mensagem: "Não foi possível foi atualizar a tabela")
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        celula.textLabel?.text = itens[indexPath.row].nome
        return celula
    }
    
    // MARK: - UITableViewDelegate
    
    // captura a seleção do usuario na tabela
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = tableView.cellForRow(at: indexPath) else { return }
        let item = itens[indexPath.row]
        
        if (celula.accessoryType == .none) {
            celula.accessoryType = .checkmark
            itensSelecionados.append(item)
        } else {
            celula.accessoryType = .none
            
            if let position = itensSelecionados.firstIndex(of: item) {
                itensSelecionados.remove(at: position)
            }
        }
        
    }
    
    func recuperaRefeicaoDoFormulario() -> Refeicao? {
        guard let nomeDaRefeicao = nomeTextField?.text else {
            return nil
        }
        
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return nil
        }
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
        refeicao.itens = itensSelecionados
        
        return refeicao
    }
    
    // MARK: - IBActions
    @IBAction func adicionar() {
        if let refeicao = recuperaRefeicaoDoFormulario() {
            // remove screen stack
            delegate?.add(refeicao)
            navigationController?.popViewController(animated: true)
        } else {
            Alerta(controller: self).exibe(mensagem: "Erro ao criar uma refeição")
        }
        
        
    }
}

