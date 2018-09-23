import UIKit

class MesCell: UITableViewCell {

    // MARK: - Propriedades

    var grupo: Grupo!

    private var _fixa: Fixa?

    var fixa: Fixa? {
        get {
            return _fixa
        }

        set {
            _fixa = newValue

            if let fixa = fixa {
                diaLabel.text = ("0" + String(fixa.vencimento)).suffix(2).description
                descricaoLabel.text = fixa.nome
            }
        }
    }

    private var _pagamento: Pagamento?

    var pagamento: Pagamento? {
        get {
            return _pagamento
        }

        set {
            _pagamento = newValue

            if fixa == nil {
                diaLabel.text = String(pagamento!.data!.day).padding(toLength: 2, withPad: "0")
                descricaoLabel.text = pagamento!.description
            }

            valorLabel.text = _pagamento?.total.string(fractionDigits: 2)
            setBold()
        }
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var diaLabel: UILabel!

    @IBOutlet private weak var descricaoLabel: UILabel!

    @IBOutlet private weak var valorLabel: UILabel!

    // MARK: - Privados

    private func setBold() {
        let isBold = _pagamento?.data?.in(region: .current).isToday ?? false
        MesCell.setFont(bold: isBold, for: diaLabel)
        MesCell.setFont(bold: isBold, for: descricaoLabel)
    }

    private static func setFont(bold: Bool, for label: UILabel) {
        if bold {
            label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        } else {
            label.font = UIFont.systemFont(ofSize: label.font.pointSize)
        }
    }

    // MARK: - View

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //    }
}
