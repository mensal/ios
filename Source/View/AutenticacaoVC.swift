import UIKit
import LocalAuthentication

extension UIButton {

    open override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
}

typealias AutenticacaoCallback = (_ sucesso: Bool) -> Void

class AutenticacaoVC: UIViewController {

    @IBOutlet private weak var loginLabel: UITextField!

    @IBOutlet private weak var senhaLabel: UITextField!

    @IBOutlet private weak var logarButton: UIButton!

    private static var mostrando = false

    private var callback: AutenticacaoCallback?

    private var habilitador: Enabler?

    @IBAction private func logar() {
        let credenciais = Credenciais(
            loginLabel.text?.trimmingCharacters(in: .whitespaces) ?? "",
            senhaLabel.text?.trimmingCharacters(in: .whitespaces) ?? ""
        )

        loginLabel.resignFirstResponder()
        senhaLabel.resignFirstResponder()
        logarButton.isEnabled = false

        AutenticacaoManager.autenticar(credenciais) { sucesso in
            if sucesso {
                self.dismiss(animated: true) {
                    self.callback?(true)
                }
            } else {
                self.present(self.falhaDeAutenticacao(), animated: true)
            }
        }
    }

    func falhaDeAutenticacao() -> UIAlertController {
        let alert = UIAlertController(title: "Falha no login", message: "O usuário ou a senha informados são inválidos.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tentar novamente", style: .default) { _ in
            self.loginLabel.becomeFirstResponder()
            self.logarButton.isEnabled = true
        })
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel) { _ in
            self.cancelar()
        })

        return alert
    }

    @IBAction private func cancelar() {
        dismiss(animated: true) {
            self.callback?(false)
        }
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
                authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Acesse com a digital") { success, error in
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

        loginLabel.delegate = self
        senhaLabel.delegate = self

        logarButton.isEnabled = false
        habilitador = Enabler(required: [loginLabel, senhaLabel], dependent: [logarButton])

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

extension AutenticacaoVC: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            senhaLabel.becomeFirstResponder()
        case 2:
            logar()
        default:
            break
        }

        return true
    }
}
