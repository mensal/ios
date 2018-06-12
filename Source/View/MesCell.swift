import UIKit

class MesCell: UITableViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet weak var dia: UILabel!
    
    @IBOutlet weak var descricao: UILabel!
    
    @IBOutlet weak var valor: UILabel!
    
    // MARK: - View
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
}
