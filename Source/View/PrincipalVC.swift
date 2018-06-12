import UIKit

class PrincipalVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pushViewController(MesVC.corrente(), animated: false)
    }
}
