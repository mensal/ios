import UIKit

class MesesVC: UITableViewController {
    
    // MARK: - Propriedades
    
    private var _meses: [Mes]?
    
    private var meses: [Mes] {
        get {
            if _meses == nil {
                _meses = MesManager.obterTodos().reversed()
            }
            
            return _meses!
        }
    }

    // MARK: - Declarados
    
    private func converterAno(_ section: Int) -> Int {
        return Date.currentYear() - section
    }
    
    private func obterMeses(_ section: Int) -> [Mes] {
        return MesManager.extrairMeses(meses, ano: converterAno(section))
    }

    // MARK: - View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table View Controller

    override func numberOfSections(in tableView: UITableView) -> Int {
        return MesManager.obterAnos().count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(converterAno(section))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return obterMeses(section).count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)

        let mes = obterMeses(indexPath.section)[indexPath.row]
        cell.textLabel?.text = mes.nome

        return cell
    }
}
