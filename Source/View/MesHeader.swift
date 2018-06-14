import UIKit

class MesHeader: UITableViewHeaderFooterView {

    // MARK: - IBOutlets

    @IBOutlet weak var grupoLabel: UILabel!
    
    @IBOutlet weak var atualizandoActivity: UIActivityIndicatorView!
    
    // MARK: - Propriedades
    
    private var _grupo: Grupo?
    
    var grupo: Grupo? {
        get {
            return _grupo
        }
        
        set {
            _grupo = newValue
            grupoLabel.text = newValue?.nomePlural?.uppercased()
        }
    }

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
