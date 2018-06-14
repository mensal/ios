import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

class FixaResponse {
    var id: UUID!
    var nome: String!
    var vencimento: Int!
}

class FixaProxy {
    
    // MARK: - Construtores
    
    private init() {
    }
    
    // MARK: - Estáticos
    
    static func obterTodos(_ callback: @escaping ([FixaResponse]) -> ()) {
        let headers = AppConfig.shared.authHeader
        
        Alamofire.request(
            AppConfig.shared.apiBaseUrl + "/tipo/fixas?ano=0&mes=0",
            method: .get,
            headers: headers).responseSwiftyJSON{ response in
                var resultado = [FixaResponse]()
                
                response.result.value?.forEach { _, json in
                    let res = FixaResponse()
                    
                    res.id         = UUID(uuidString: json["id"].string!)
                    res.nome       = json["nome"].string!
                    res.vencimento = json["vencimento"].int!
                    
                    resultado.append(res)
                }
                
                callback(resultado)
        }
    }
}
