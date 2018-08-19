import UIKit
import LocalAuthentication

typealias AutenticacaoCallback = (_ sucesso: Bool) -> Void

class AutenticacaoVC: UIViewController {

    @IBOutlet weak var loginLabel: UITextField!

    @IBOutlet weak var senhaLabel: UITextField!

    @IBOutlet weak var logarButton: UIButton!

    private static var mostrando = false

    private var callback: AutenticacaoCallback?

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

    private static func instancia() -> AutenticacaoVC {
        return UIStoryboard.autenticacao.instantiateViewController(withIdentifier: "AutenticacaoVC") as! AutenticacaoVC
    }

    static func autenticar(sender: UIViewController, callback: @escaping AutenticacaoCallback) {
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
                                callback(sucesso)
                            } else {
                                exibirTelaLogin(sender, callback)
                            }
                        }

                    } else if let error = error {
                        switch error {
                        case LAError.userCancel:
                            mostrando = false
                            callback(false)
                        default:
                            exibirTelaLogin(sender, callback)
                        }
                    }
                }
            } else {
                exibirTelaLogin(sender, callback)
            }

        } else {
            exibirTelaLogin(sender, callback)
        }
    }

    static private func exibirTelaLogin(_ sender: UIViewController, _ callback: @escaping AutenticacaoCallback) {
        DispatchQueue.main.async {
            let autenticacaoVC = AutenticacaoVC.instancia()
            autenticacaoVC.callback = callback

            sender.present(autenticacaoVC, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.subviews.filter { $0 is UITextField }.map { $0 as! UITextField}.forEach { _ in

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
