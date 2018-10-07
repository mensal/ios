import UIKit
import SwiftDate

extension Grupo {

    var sessoes: [Int] {
        if let id = id {
            switch id {
            case .fixas:
                return [3]
            case .diaristas:
                return [0, 3]
            case .combustiveis:
                return [1, 3]
            case .diversas:
                return [2, 3]
            }
        }

        return []
    }
}

fileprivate extension UITableViewCell {
    
    var textField: UITextField? {
        return self.contentView.subviews.filter { $0 is UITextField }.first as? UITextField
    }
}

private let diariaCellId              = "diariaCell"

private let automovelCellId           = "automovelCell"
private let odometroCellId            = "odometroCell"
private let litrosCellId              = "litrosCell"

private let tipoDespesaCellId         = "tipoDespesaCell"
private let observacaoDespesaCellId   = "observacaoDespesaCell"

private let dataPagamentoCellId       = "dataPagamentoCell"
private let dataPagamentoPickerCellId = "dataPagamentoPickerCell"
private let rateioCellId              = "rateioCell"

class EdicaoVC: UITableViewController {

    // MARK: - Propriedades

    var mes: Mes!

    var grupo: Grupo!

    var fixa: Fixa?

    var pagamento: Pagamento?

    private let rateioSection = 3

    // MARK: - Private

    private func isRateioSection(at section: Int) -> Bool {
        return section == rateioSection
    }

    private func isRateioCell(at indexPath: IndexPath) -> Bool {
        return isRateioSection(at: indexPath.section) && indexPath.row > 1
    }

    private func atualizarDia() {
        let dia = diaPickerView.selectedRow(inComponent: 0) + 1
        let string = Date.parse(year: mes.ano!, month: mes.ordinal!, day: dia)!.toString()

        print(string)

//        let dia = diaPickerView.selectedRow(inComponent: 0) + 1
    }
    
    private func carregar(cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {
        if isRateioSection(at: indexPath.section) {
            if isRateioCell(at: indexPath) {
                let index = indexPath.row - 2
                let cell = cell as! RateioCell

                let usuario =  UsuarioManager().obterTodos(persistentContainer.viewContext)[index]
                
                cell.nomeLabel.text = usuario.nome
                cell.textField?.text = pagamento?.rateiosArray?.filter { $0.usuario?.id == usuario.id }.first?.valor.description
                
            } else {
                switch cell.reuseIdentifier {
                case dataPagamentoPickerCellId:
                    break
                default:
                    //cell.detailTextLabel?.text = pagamento?.data?.stringForDatePicker ?? "Hoje"
                    //diaPickerView.sele
                    
                    break
                }
            }
            
        } else {
            let nenhum = "Nenhum"
            
            switch cell.reuseIdentifier {
            case diariaCellId:
                cell.detailTextLabel?.text = (pagamento as? PagamentoDiarista)?.diaria?.valor.description ?? nenhum
            
            case automovelCellId:
                cell.detailTextLabel?.text = (pagamento as? PagamentoCombustivel)?.veiculo?.nome ?? nenhum
            case odometroCellId:
                cell.textField?.text = (pagamento as? PagamentoCombustivel)?.odometro.description
            case litrosCellId:
                cell.textField?.text = (pagamento as? PagamentoCombustivel)?.litro.description

            case tipoDespesaCellId:
                cell.detailTextLabel?.text = (pagamento as? PagamentoDiversa)?.diversa?.nome ?? nenhum
            case observacaoDespesaCellId:
                cell.textField?.text = (pagamento as? PagamentoDiversa)?.observacao
                
            default:
                break
            }
        }
        
//        if isRateioCell(at: indexPath) {
//            let cell = cell as! RateioCell
//            cell.nomeLabel.text = UsuarioManager().obterTodos(persistentContainer.viewContext)[indexPath.row - 2].nome
//        } else {
//            switch cell.reuseIdentifier {
//            case diariaCellId:
//                break
//            default:
//                break
//            }
//
//        }
        
        
        return cell
    }

    // MARK: - IBOutlet

    @IBOutlet private weak var diaPickerView: UIPickerView!

    // MARK: - IBAction

    @IBAction private func cancelar(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }

    // MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()

        diaPickerView.dataSource = self
        diaPickerView.delegate   = self

        //        self.tableView.sectionHeaderHeight = 0;
        //        self.tableView.sectionFooterHeight = 0;

        tableView.register(UINib.rateioCell, forCellReuseIdentifier: rateioCellId)

        //        print("\(grupo.nomeSingular!) \(String(describing: pagamento?.id?.description)) \(String(describing: pagamento?.data?.stringForDatePicker)) \(String(describing: pagamento?.total.description)) \(String(describing: fixa?.nome))")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if grupo.dinamico ?? false {
            title = grupo?.nomeSingular
        } else {
            title = fixa?.nome
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Table View Controller

extension EdicaoVC {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isRateioCell(at: indexPath) {
            return carregar(cell: tableView.dequeueReusableCell(withIdentifier: rateioCellId, for: indexPath), at: indexPath)
        } else {
            return carregar(cell: super.tableView(tableView, cellForRowAt: indexPath), at: indexPath)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if isRateioCell(at: indexPath) {
            return UITableViewAutomaticDimension
        } else if grupo.sessoes.contains(indexPath.section) {
            return super.tableView(tableView, heightForRowAt: indexPath)
        } else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = super.tableView(tableView, numberOfRowsInSection: section)

        if isRateioSection(at: section) {
            count = UsuarioManager().obterTodos(persistentContainer.viewContext).count + 2
        }

        return count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let control = tableView.cellForRow(at: indexPath)?.contentView.subviews.filter { $0 is UIControl }.map { $0 as! UIControl }.first

        if !(control?.isFirstResponder ?? false) {
            control?.becomeFirstResponder()
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let diferenca: CGFloat = (grupo.sessoes.first! == section) ? 36 : 0
        return grupo.sessoes.contains(section) ? super.tableView(tableView, heightForHeaderInSection: section) + diferenca : 0.01
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return grupo.sessoes.contains(section) ? super.tableView(tableView, heightForFooterInSection: section) : 0.01
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return grupo.sessoes.contains(section) ? super.tableView(tableView, titleForFooterInSection: section) : nil
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return grupo.sessoes.contains(section) ? super.tableView(tableView, viewForHeaderInSection: section) : UIView(frame: .zero)
    }

    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if isRateioCell(at: indexPath) {
            return 0
        } else {
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        }
    }
}

// MARK: - Picker View

extension EdicaoVC: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mes.fim?.day ?? 0
    }
}

extension EdicaoVC: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let dia = row + 1
        var attributes = [NSAttributedStringKey: Any]()

        if mes.isCorrente ?? false && Date.currentDay() == dia {
            attributes[.foregroundColor] = pickerView.tintColor
        }

        let string = Date.parse(year: mes.ano!, month: mes.ordinal!, day: dia)!.stringForDatePicker!
        return NSAttributedString(string: string, attributes: attributes)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        atualizarDia()
    }
}
