import UIKit
import Zip

private let mostraMesSegueId = "mostraMes"

class MesesVC: UITableViewController {

    // MARK: - Propriedades

    private let meses = Cache<[Mes]> { MesManager.obterTodos().reversed() }

    // MARK: - UIActions

    @IBAction private func compartilhar() {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sqlURL = documentsURL.appendingPathComponent("sql-dump.sql")
        let sqliteURL = persistentContainer.persistentStoreDescriptions.first!.url!

        do {
            try DatabaseExporter.exportar(persistentContainer.viewContext).write(to: sqlURL)
            let zipURL = try Zip.quickZipFiles([sqlURL, sqliteURL], fileName: "database-backup-\(Date().iso8601Extended.replacingOccurrences(of: ":", with: "_"))")
            try? FileManager.default.removeItem(at: sqlURL)

            let vc = UIActivityViewController(activityItems: [zipURL], applicationActivities: [])
            vc.completionWithItemsHandler = { activity, success, items, error in
                try? FileManager.default.removeItem(at: zipURL)
            }

            present(vc, animated: true)

        } catch {
            print(error)
        }
    }

    // MARK: - Declarados

    private func converterAno(_ section: Int) -> Int {
        return Date.currentYear() - section
    }

    private func obterMeses(_ section: Int) -> [Mes] {
        return MesManager.extrairMeses(meses.cached, ano: converterAno(section))
    }

    private func obterMes(_ indexPath: IndexPath?) -> Mes? {
        guard let indexPath = indexPath else {
            return nil
        }

        return obterMeses(indexPath.section)[indexPath.row]
    }

    private func mesSelecionado() -> Mes? {
        return obterMes(tableView.indexPathForSelectedRow)
    }

    // MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case mostraMesSegueId:
            if let destination = segue.destination as? MesVC {
                destination.mes = mesSelecionado()!
            }
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        meses.clear()
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
        let mes = obterMes(indexPath)

        cell.textLabel?.text = mes?.nome

        if mes?.isCorrente ?? false {
            cell.textLabel?.textColor = view.tintColor
        }

        return cell
    }
}
