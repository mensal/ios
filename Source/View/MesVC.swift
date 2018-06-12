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
    
    private var _grupos: [Grupo]?
    
    private var grupos: [Grupo] {
        get {
            if _grupos == nil {
                _grupos = GrupoManager.obterTodos()
            }
            
            return _grupos!
        }
    }
    
    // MARK: - Conveniência
    
    static func corrente() -> MesVC {
        let resultado = UIStoryboard.lancamento.instantiateViewController(withIdentifier: "MesVC") as! MesVC
        resultado.mes = Mes.corrente()
        
        return resultado
    }

    // MARK: - IBActions
    
    @IBAction func adicionar(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        GrupoManager.obterTodos().filter { $0.dinamico ?? false }.forEach { grupo in
            let action = GrupoAlertAction(title: grupo.nome, style: .default) {
                self.performSegue(withIdentifier: mostraEdicaoSegueId, sender: $0)
            }
            
            action.grupo = grupo
            alert.addAction(action)
        }
        
        present(alert, animated: true)
    }
    
    // MARK: - View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = mes.nomeCompleto
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if sender is GrupoAlertAction {
            let action = sender as! GrupoAlertAction
            print(action.grupo!.nome!)
            
        } else {
            print("cell")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        _grupos = nil
    }
    
    // MARK: - Table View Controller
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return grupos.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38 + (section == 0 ? 17.5 : 0)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableCell(withIdentifier: mesHeaderId) as! MesHeader
        view.grupoLabel.text = grupos[section].nome?.uppercased()

        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mesCellId, for: indexPath) as! MesCell
        
//        cell.textLabel?.text = "Nome da despesa"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
