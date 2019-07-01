import Foundation
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON

class AutenticacaoRequest: ProxyRequest {
    var login: String?
    var senha: String?

    var json: JSON? {
        let json = [
            "login": login ?? "",
            "senha": senha ?? ""
        ]

        return JSON(json)
    }
}

class AutenticacaoProxy: Proxy {

    var path = "/autenticacao"

    var autenticacaoDelegate: AutenticacaoDelegate?

    func autenticar(_ request: AutenticacaoRequest, _ completo: @escaping (String?) -> Void) {
        Alamofire.request(
            AppConfig.shared.apiBaseUrl.appendingPathComponent(path),
            method: .post,
            parameters: request.json?.dictionaryObject,
            encoding: JSONEncoding.default).responseString { response in

                switch response.response?.statusCode {
                case 200:
                    completo(response.result.value!)
                default:
                    completo(nil)
                }
        }
    }
}
