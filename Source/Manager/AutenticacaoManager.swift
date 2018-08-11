import Foundation

class AutenticacaoManager {

    // MARK: - Construtores

    private init() {
    }

    // MARK: - Públicos

    static func autenticar(_ credenciais: Credenciais, sucesso: @escaping (Bool) -> Void) {
        let request = AutenticacaoRequest()
        request.login = credenciais.login
        request.senha = credenciais.senha

        AutenticacaoProxy().autenticar(request) { token in
            if let token = token {
                AppConfig.shared.credenciais = credenciais
                AppConfig.shared.token = token
                sucesso(true)

            } else {
                sucesso(false)
            }
        }
    }

}
