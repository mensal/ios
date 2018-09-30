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

private let rateioCellId = "rateioCell"

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

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return grupo.sessoes.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let section = grupo.sessoes[section]
        var count = super.tableView(tableView, numberOfRowsInSection: section)
//        var count = grupo.sessoes.count

        if isRateioSection(at: section) {
            count = UsuarioManager().obterTodos(persistentContainer.viewContext).count + 2
        }

        return count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let x: CGFloat = (grupo.sessoes.first! == section) ? 40 : 0
        return grupo.sessoes.contains(section) ? super.tableView(tableView, heightForHeaderInSection: section) + x : 0.01
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let section = grupo.sessoes[indexPath.section]
//        let indexPath = IndexPath(row: indexPath.row, section: section)

        if isRateioCell(at: indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: rateioCellId, for: indexPath) as! RateioCell
            cell.nomeLabel.text = UsuarioManager().obterTodos(persistentContainer.viewContext)[indexPath.row - 2].nome

            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }

    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
//        let section = grupo.sessoes[indexPath.section]
//        let indexPath = IndexPath(row: indexPath.row, section: section)

        if isRateioCell(at: indexPath) {
            return 0
        } else {
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(indexPath.section)

//        let section = grupo.sessoes[indexPath.section]
//        let indexPath = IndexPath(row: indexPath.row, section: section)
//
        if isRateioCell(at: indexPath) {
            return UITableViewAutomaticDimension
        } else if grupo.sessoes.contains(indexPath.section) {
            return super.tableView(tableView, heightForRowAt: indexPath)
        } else {
            return 0
        }
//        } else {
//            return super.tableView(tableView, heightForRowAt: indexPath)
//        }
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

    //    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //    }
}
