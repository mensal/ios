import UIKit
import SwiftDate

class EdicaoVC: UITableViewController {

    // MARK: - Propriedades

    var mes: Mes!

    var grupo: Grupo!

    // MARK: - IBOutlet

    @IBOutlet weak var diaPickerView: UIPickerView!

    // MARK: - IBAction

    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }

    // MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()

        diaPickerView.dataSource = self
        diaPickerView.delegate   = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        title = grupo?.nomeSingular
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table View Controller

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "celula", for: indexPath)
//
//        cell.textLabel?.text = "1"
//
//        return cell
//    }
}

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
