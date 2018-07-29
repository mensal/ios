import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

class AutenticacaoRequest: ProxyRequest {
    var usuario: String?
    var senha: String?

    var json: JSON? {
        let json = [
            "login": usuario ?? "",
            "senha": senha ?? ""
        ]
        
        return JSON(json)
    }
}

class AutenticacaoProxy: Proxy {

    var path = "/autenticacao"
    
    func autenticar(_ request: AutenticacaoRequest) {
        Alamofire.request(
            AppConfig.shared.apiBaseUrl.appendingPathComponent(path),
            method: .post,
            parameters: request.json?.dictionaryObject,
            encoding: JSONEncoding.default).responseSwiftyJSON { response in
                
//                if response.response?.statusCode == 401 {
//                    self.delegate?.didReceiveNotAuthenticatedRespose()
//                }
//
//                let resultado = response.result.value?.map { S($1) }
//                callback(resultado ?? [S]())
        }
    }
}
