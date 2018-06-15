import UIKit

fileprivate class GrupoAlertAction: UIAlertAction {
    var grupo: Grupo?
}

fileprivate class Pagamentos {
    
    private let mes: Mes
    
    init(_ mes: Mes) {
        self.mes = mes
    }
    
    lazy var fixas = { Cache<[PagamentoFixa]> { PagamentoFixaManager().obterTodos(persistentContainer.viewContext) }}()
    lazy var diversas = { Cache<[PagamentoDiversa]> { PagamentoDiversaManager().obterTodos(persistentContainer.viewContext) }}()
    lazy var diaristas = { Cache<[PagamentoDiarista]> { PagamentoDiaristaManager().obterTodos(persistentContainer.viewContext) }}()
    lazy var combustiveis = { Cache<[PagamentoCombustivel]> { PagamentoCombustivelManager().obterTodos(persistentContainer.viewContext) }}()
    
    func clear() {
        fixas.clear()
        diversas.clear()
        diaristas.clear()
        combustiveis.clear()
    }
}

private let mostraEdicaoSegueId = "mostraEdicao"
private let mostraNovoSegueId   = "mostraNovo"
private let mesHeaderId         = "mesHeader"
private let mesCellId           = "mesCell"

class MesVC: UITableViewController {
        
    // MARK: - Propriedades
    
    var mes: Mes!
    
    private let grupos = Cache<[Grupo]> { GrupoManager.obterTodos() }
    
    private let fixas = Cache<[Fixa]> { FixaManager().obterTodos(persistentContainer.viewContext) }
    
    private lazy var pagamentos = { Pagamentos(self.mes) }()
    
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
                self.performSegue(withIdentifier: mostraNovoSegueId, sender: $0)
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
        
        ////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////
        
        let context = persistentContainer.viewContext
        
        UsuarioManager().sincronizar(context) {
            FixaManager().sincronizar(context) {
                DiversaManager().sincronizar(context) {
                    DiariaManager().sincronizar(context) {
                        VeiculoManager().sincronizar(context) {
                            PagamentoFixaManager().sincronizar(context) {
                                PagamentoDiversaManager().sincronizar(context) {
                                    PagamentoDiaristaManager().sincronizar(context) {
                                        PagamentoCombustivelManager().sincronizar(context) {
                                            self.fixas.clear()
                                            self.pagamentos.clear()
                                            self.tableView.reloadData()
                                            
                                            try! context.save()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
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
//            let nc = segue.destination as! UINavigationController
//            let vc = nc.topViewController as! EdicaoVC
            let vc = segue.destination as! EdicaoVC
            vc.grupo = grupo
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        grupos.clear()
    }
    
    // MARK: - Table View Controller
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return grupos.cache.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38 + (section == 0 ? 17.5 : 0)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: mesHeaderId) as! MesHeader
        header.grupo = grupos.cache[section]

        return header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return fixas.cache.count
        case 1:
            return pagamentos.diversas.cache.count
        case 2:
            return pagamentos.diaristas.cache.count
        case 3:
            return pagamentos.combustiveis.cache.count

        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mesCellId, for: indexPath) as! MesCell
        
        switch indexPath.section {
        case 0:
            let fixa = fixas.cache[indexPath.row]
            
            cell.diaLabel.text = ("0" + String(fixa.vencimento)).suffix(2).description
            cell.descricaoLabel.text = fixa.nome
            cell.valorLabel.text = pagamentos.fixas.cache.first(where: { $0.fixa?.nome == fixa.nome })?.total.description
            
        case 1:
            let pagamento = pagamentos.diversas.cache[indexPath.row]
            
            cell.diaLabel.text = ("0" + String(pagamento.data?.day ?? 0)).suffix(2).description
            cell.descricaoLabel.text = pagamento.diversa?.nome
            cell.valorLabel.text = pagamento.total.description

        case 2:
            let pagamento = pagamentos.diaristas.cache[indexPath.row]
            
            cell.diaLabel.text = ("0" + String(pagamento.data?.day ?? 0)).suffix(2).description
            cell.descricaoLabel.text = ""
            cell.valorLabel.text = pagamento.total.description

        case 3:
            let pagamento = pagamentos.combustiveis.cache[indexPath.row]
            
            cell.diaLabel.text = ("0" + String(pagamento.data?.day ?? 0)).suffix(2).description
            cell.descricaoLabel.text = pagamento.veiculo?.nome
            cell.valorLabel.text = pagamento.total.description

        default:
            break
        }
        
        cell.grupo = grupos.cache[indexPath.section]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
