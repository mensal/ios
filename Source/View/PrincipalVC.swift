import UIKit

class PrincipalVC: UINavigationController {

    // MARK: - View Controller

    override func viewDidLoad() {
        super.viewDidLoad()

        pushViewController(MesVC.corrente(), animated: false)
    }
}
