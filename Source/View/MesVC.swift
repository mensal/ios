import UIKit
import Localize_Swift

class MesVC: UITableViewController {
    
    // MARK: - Conveniência
    
    static func corrente() -> MesVC {
        let resultado = UIStoryboard.main().instantiateViewController(withIdentifier: "MesVC") as! MesVC
        resultado.mes = Mes.corrente()
        
        return resultado
    }
    
    // MARK: - Propriedades
    
    var mes: Mes!
    
    private var _grupos: [String]?
    
    private var grupos: [String] {
        get {
            if _grupos == nil {
                _grupos = GrupoManager.obterTodos()
            }
            
            return _grupos!
        }
    }
    
    // MARK: - View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = mes.nomeCompleto
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View Controller
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return grupos.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return grupos[section].localized()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
        
        cell.textLabel?.text = "1"
        
        return cell
    }
}
