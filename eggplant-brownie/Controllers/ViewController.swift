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
    var itens: [Item] = [
        Item(nome: "Molho de tomate", calorias: 40.0),
        Item(nome: "Queijo", calorias: 60.0),
        Item(nome: "Molho de Pimenta", calorias: 10.0),
        Item(nome: "Massa", calorias: 40.0),
        Item(nome: "Orégano", calorias: 2.0),
        Item(nome: "Cebola", calorias: 5.0),
    ]
    
    var itensSelecionados: [Item] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        let btnAdicionaItem = UIBarButtonItem(title: "adicionar", style: .plain, target: self, action: #selector( adicionarItem))
        
        navigationItem.rightBarButtonItem = btnAdicionaItem
    }
    
    @objc func adicionarItem() {
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        itensTableView.reloadData()
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
    
    // MARK: - IBActions
    @IBAction func adicionar() {
                
        guard let nomeDaRefeicao = nomeTextField?.text else {
            return
        }
        
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return
        }
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
        refeicao.itens = itensSelecionados
        
        // remove screen stack
        delegate?.add(refeicao)
        navigationController?.popViewController(animated: true)
    }
}

