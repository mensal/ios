import UIKit
import LocalAuthentication

class AutenticacaoVC: UIViewController {

    @IBOutlet weak var loginLabel: UITextField!
   
    @IBOutlet weak var senhaLabel: UITextField!
    
    private static var mostrando = false
    
    @IBAction func logar(_ sender: UIButton) {
        let credenciais = Credenciais(
            loginLabel.text?.trimmingCharacters(in: .whitespaces) ?? "",
            senhaLabel.text?.trimmingCharacters(in: .whitespaces) ?? ""
        )
        
        logar(credenciais)
    }
    
    @IBAction func cancelar(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func logar(_ credenciais: Credenciais) {
        let request = AutenticacaoRequest()
        request.login = credenciais.login
        request.senha = credenciais.senha
        
        let proxy = AutenticacaoProxy()
        proxy.autenticar(request) { token in
            if let token = token {
                AppConfig.shared.credenciais = credenciais
                AppConfig.shared.token = token
                
                self.dismiss(animated: true)
            }
        }
    }
    
    // MARK: - Conveniência
    
    static func obter() -> AutenticacaoVC {
        return UIStoryboard.autenticacao.instantiateViewController(withIdentifier: "AutenticacaoVC") as! AutenticacaoVC
    }
    
    static func mostrar (sender: UIViewController) {
        if mostrando {
            return
        }
        
        mostrando = true
        
        if let credenciais = AppConfig.shared.credenciais {
            // pede autenticacao biometrica
            let authContext = LAContext()
            
            var error: NSError?
            if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Teste") { success, error in
                    if success {
                        AutenticacaoVC.obter().logar(credenciais)
//
//
//                        mostrando = false
//                        sender.viewWillAppear(false)
                    }
                }
            }
            
        } else {
            sender.present(AutenticacaoVC.obter(), animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AutenticacaoVC.mostrando = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        AutenticacaoVC.mostrando = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
