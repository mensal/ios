import UIKit

class MesCell: UITableViewCell {

    // MARK: - Propriedades

    var grupo: Grupo?

    // MARK: - IBOutlets

    @IBOutlet weak var diaLabel: UILabel!

    @IBOutlet weak var descricaoLabel: UILabel!

    @IBOutlet weak var valorLabel: UILabel!

    // MARK: - View

    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
}
