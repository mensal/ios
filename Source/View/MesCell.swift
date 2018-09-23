import UIKit

class MesCell: UITableViewCell {

    // MARK: - Propriedades

    var grupo: Grupo!

    var fixa: Fixa?

    private var _pagamento: Pagamento?

    var pagamento: Pagamento? {
        get {
            return _pagamento
        }

        set {
            _pagamento = newValue

            let isBold = _pagamento?.data?.in(region: .current).isToday ?? false
            MesCell.setFont(bold: isBold, for: diaLabel)
            MesCell.setFont(bold: isBold, for: descricaoLabel)
        }
    }

    // MARK: - IBOutlets

    @IBOutlet weak var diaLabel: UILabel!

    @IBOutlet weak var descricaoLabel: UILabel!

    @IBOutlet weak var valorLabel: UILabel!

    // MARK: - Privados

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
