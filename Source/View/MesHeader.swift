import UIKit

class MesHeader: UITableViewHeaderFooterView {

    // MARK: - IBOutlets

    @IBOutlet weak var grupoLabel: UILabel!
    
    @IBOutlet weak var atualizandoActivity: UIActivityIndicatorView!

    // MARK: - View
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Públicos
    
    func iniciaAtividade() {
        atualizandoActivity.startAnimating()
    }
    
    func paraAtividade() {
        atualizandoActivity.stopAnimating()
    }
}
