import UIKit
import SwiftDate

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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = super.tableView(tableView, numberOfRowsInSection: section)

        if isRateioSection(at: section) {
            count = UsuarioManager().obterTodos(persistentContainer.viewContext).count + 2
        }

        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isRateioCell(at: indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: rateioCellId, for: indexPath) as! RateioCell
            cell.nomeLabel.text = UsuarioManager().obterTodos(persistentContainer.viewContext)[indexPath.row - 2].nome

            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }

    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if isRateioCell(at: indexPath) {
            return 0
        } else {
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isRateioCell(at: indexPath) {
            return -1
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
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

    //    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //    }
}
