import UIKit

class AutenticacaoVC: UIViewController {

    @IBOutlet weak var usuarioLabel: UITextField!
   
    @IBOutlet weak var senhaLabel: UITextField!
    
    @IBAction func logar(_ sender: UIButton) {
        
        let request = AutenticacaoRequest()
        request.usuario = usuarioLabel.text
        request.senha = senhaLabel.text
        
        AutenticacaoProxy().autenticar(request)
        
//        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Conveniência
    
    static func obter() -> AutenticacaoVC {
        return UIStoryboard.autenticacao.instantiateViewController(withIdentifier: "AutenticacaoVC") as! AutenticacaoVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
