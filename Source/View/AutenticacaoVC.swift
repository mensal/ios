import UIKit
import LocalAuthentication

class AutenticacaoVC: UIViewController {

    @IBOutlet weak var loginLabel: UITextField!

    @IBOutlet weak var senhaLabel: UITextField!

    @IBOutlet weak var logarButton: UIButton!
    
    private static var mostrando = false

    @IBAction func logar() {
        let credenciais = Credenciais(
            loginLabel.text?.trimmingCharacters(in: .whitespaces) ?? "",
            senhaLabel.text?.trimmingCharacters(in: .whitespaces) ?? ""
        )

        AutenticacaoManager.autenticar(credenciais) { sucesso in
            if sucesso {
                self.dismiss(animated: true)
            }
        }
    }

    @IBAction func cancelar() {
        dismiss(animated: true)
    }

    // MARK: - Conveniência

    private static func obter() -> AutenticacaoVC {
        return UIStoryboard.autenticacao.instantiateViewController(withIdentifier: "AutenticacaoVC") as! AutenticacaoVC
    }

    static func autenticar(sender: UIViewController) {
        if mostrando {
            return
        }

        mostrando = true

        if let credenciais = AppConfig.shared.credenciais {
            let authContext = LAContext()

            var error: NSError?
            if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Teste") { success, error in
                    if success {
                        AutenticacaoManager.autenticar(credenciais) { sucesso in
                            if sucesso {
                                mostrando = false
                            } else {
                                mostrar(sender)
                            }
                        }

                    } else if let error = error {
                        switch error {
                        case LAError.userCancel:
                            mostrando = false
                        default:
                            mostrar(sender)
                        }
                    }
                }
            } else {
                mostrar(sender)
            }

        } else {
            mostrar(sender)
        }
    }

    static private func mostrar(_ sender: UIViewController) {
        DispatchQueue.main.async {
            sender.present(AutenticacaoVC.obter(), animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.subviews.filter { $0 is UITextField }.map { $0 as! UITextField}.forEach { textField in
            
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20));
//            imageView.image = UIImage(named: "Logo");
//            $0.leftViewMode = .always
//            $0.leftView = imageView
//
//            $0.borderStyle = .roundedRect
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        AutenticacaoVC.mostrando = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loginLabel.becomeFirstResponder()
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
