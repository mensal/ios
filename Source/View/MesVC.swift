import UIKit

private class GrupoAlertAction: UIAlertAction {
    var grupo: Grupo?
}

private let mostraEdicaoSegueId = "mostraEdicao"
private let mesHeaderId         = "mesHeader"
private let mesCellId           = "mesCell"

extension Array where Element : Cache<[Pagamento]> {

    func clear() {
        self.forEach { $0.clear() }
    }
}

class MesVC: UITableViewController {

    // MARK: - Propriedades

    var mes: Mes!

    private let grupos = Cache<[Grupo]> { GrupoManager.obterTodos() }

    private let fixas = Cache<[Fixa]> { FixaManager().obterTodos(persistentContainer.viewContext) }
    
    lazy var pagamentos: [Cache<[Pagamento]>] = [
        Cache<[Pagamento]> { PagamentoFixaManager().obter(self.mes, persistentContainer.viewContext) },
        Cache<[Pagamento]> { PagamentoDiaristaManager().obter(self.mes, persistentContainer.viewContext) },
        Cache<[Pagamento]> { PagamentoCombustivelManager().obter(self.mes, persistentContainer.viewContext) },
        Cache<[Pagamento]> { PagamentoDiversaManager().obter(self.mes, persistentContainer.viewContext) }
    ]

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
        
//        AppConfig.shared.token = nil
    }

    @IBAction func atualizar(_ sender: UIRefreshControl) {
        headers().forEach { $0?.iniciaAtividade() }
        sender.endRefreshing()
    }

    // MARK: - Privados

    private func recarregar() {
        fixas.clear()
        pagamentos.clear()
        tableView.reloadData()
    }

    // MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib.mesHeader, forHeaderFooterViewReuseIdentifier: mesHeaderId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("xxxxxxxxxxxx")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = mes.nomeCompleto

        ////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////

//        let inicio = DateInRegion.init(string: "\(mes.ano!)-\(mes.stringOrdinal!)-01", format: .iso8601Auto, fromRegion: .GMT())!

//        let inicio = date.startOf(component: .month)
//        let fim = inicio.endOf(component: .month)

//        let inicio = date.at(unit: .day, value: 1)?.absoluteDate
//        let fim = date.nextMonth.at(unit: .day, value: 1)
//
//        print(mes.inicio!)
//        print(mes.fim!)

//        x.nextMonth

        let context = persistentContainer.viewContext

        UsuarioManager().sincronizar(self, context) {

            FixaManager().sincronizar(self, context) {
                DiversaManager().sincronizar(self, context) {
                    DiariaManager().sincronizar(self, context) {
                        VeiculoManager().sincronizar(self, context) {

                            PagamentoFixaManager().sincronizar(self, context) {
                                PagamentoDiversaManager().sincronizar(self, context) {
                                    PagamentoDiaristaManager().sincronizar(self, context) {
                                        PagamentoCombustivelManager().sincronizar(self, context) {

                                            self.recarregar()
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
            let nc = segue.destination as! UINavigationController
            let vc = nc.topViewController as! EdicaoVC
//            let vc = segue.destination as! EdicaoVC
            vc.grupo = grupo
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        grupos.clear()
    }

    // MARK: - Table View Controller

    override func numberOfSections(in tableView: UITableView) -> Int {
        return grupos.cached.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38 + (section == 0 ? 17.5 : 0)
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: mesHeaderId) as! MesHeader
        header.grupo = grupos.cached[section]

        return header
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return fixas.cached.count

        default:
            return pagamentos[section].cached.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mesCellId, for: indexPath) as! MesCell
//        cell.mes = self.mes

        switch indexPath.section {
        case 0:
            let fixa = fixas.cached[indexPath.row]
            let cached = pagamentos[indexPath.section].cached as! [PagamentoFixa]

            cell.diaLabel.text = ("0" + String(fixa.vencimento)).suffix(2).description
            cell.descricaoLabel.text = fixa.nome
            cell.valorLabel.text = cached.first(where: { $0.fixa?.nome == fixa.nome })?.total.string(fractionDigits: 2)

        default:
            let pagamento = pagamentos[indexPath.section].cached[indexPath.row]
            
            cell.diaLabel.text = pagamento.data?.stringGMTDay
            cell.descricaoLabel.text = pagamento.description
            cell.valorLabel.text = pagamento.total.string(fractionDigits: 2)

            break
        }

        let corTexto = (mes.isCorrente ?? false && String(Date().day) == cell.diaLabel.text) ? cell.tintColor : .black
        cell.diaLabel.textColor = corTexto
        cell.descricaoLabel.textColor = corTexto

        cell.grupo = grupos.cached[indexPath.section]

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section > 0
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let context = persistentContainer.viewContext
            var pagamento: Pagamento? = nil
            
            if indexPath.section > 0 {
                pagamento = pagamentos[indexPath.section].cached[indexPath.row]
            }

            if indexPath.section > 0 {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
                alert.addAction(UIAlertAction(title: "Apagar", style: .destructive) { _ in
                    PagamentoManager([NSSortDescriptor]()).excluir(pagamento!, context)
                    self.recarregar()
                })

                present(alert, animated: true)
            }

            try! context.save()
        }
    }
}

extension MesVC: AutenticacaoDelegate {
    
    func naoAutenticado() {
        AutenticacaoVC.mostrar(sender: self)
    }
}
