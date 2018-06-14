import UIKit

fileprivate class GrupoAlertAction: UIAlertAction {
    
    var grupo: Grupo?
}

private let mostraEdicaoSegueId = "mostraEdicao"
private let mesHeaderId         = "mesHeader"
private let mesCellId           = "mesCell"

class MesVC: UITableViewController {
        
    // MARK: - Propriedades
    
    var mes: Mes!
    
    private var grupos = Cache<Grupo> { GrupoManager.obterTodos() }
    
    private var fixas = Cache<Fixa> { FixaManager.obterTodos(persistentContainer.viewContext) }
    
    // MARK: - Conveniência
    
    static func corrente() -> MesVC {
        let resultado = UIStoryboard.lancamento.instantiateViewController(withIdentifier: "MesVC") as! MesVC
        resultado.mes = Mes.corrente()
        
        return resultado
    }

    func headers() -> [MesHeader?] {
        return (0..<tableView.numberOfSections).map { tableView.headerView(forSection: $0) as? MesHeader }
    }
    
    // MARK: - IBActions
    
    @IBAction func adicionar(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        GrupoManager.obterTodos().filter { $0.dinamico ?? false }.forEach { grupo in
            let action = GrupoAlertAction(title: grupo.nomePlural, style: .default) {
                self.performSegue(withIdentifier: mostraEdicaoSegueId, sender: $0)
            }
            
            action.grupo = grupo
            alert.addAction(action)
        }
        
        present(alert, animated: true)
    }
    
    @IBAction func atualizar(_ sender: UIRefreshControl) {
        headers().forEach { $0?.iniciaAtividade() }
        sender.endRefreshing()
    }
    
    // MARK: - View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.mesHeader, forHeaderFooterViewReuseIdentifier: mesHeaderId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = mes.nomeCompleto
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let grupo: Grupo
        
        if sender is GrupoAlertAction {
            let action = sender as! GrupoAlertAction
            grupo = action.grupo!
        } else {
            let sender = sender as! MesCell
            grupo = sender.grupo!
        }
        
        if segue.identifier == mostraEdicaoSegueId {
            let nc = segue.destination as! UINavigationController
            let vc = nc.topViewController as! EdicaoVC
            vc.grupo = grupo
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        grupos.clear()
    }
    
    // MARK: - Table View Controller
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return grupos.values.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38 + (section == 0 ? 17.5 : 0)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: mesHeaderId) as! MesHeader
        header.grupo = grupos.values[section]

        return header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return fixas.values.count
            
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mesCellId, for: indexPath) as! MesCell
        
        switch indexPath.section {
        case 0:
            let fixa = fixas.values[indexPath.row]
            
            cell.diaLabel.text = ("0" + String(fixa.vencimento)).suffix(2).description
            cell.descricaoLabel.text = fixa.nome
            cell.valorLabel.text = ""
            
        default:
            break
        }
        
        cell.grupo = grupos.values[indexPath.section]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
