import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

struct DiversaResponse {
    init() { }
    var id: UUID!
    var nome: String!
}

class DiversaProxy {
    
    // MARK: - Construtores
    
    private init() {
    }
    
    // MARK: - Estáticos
    
    static func obterTodos(_ callback: @escaping ([DiversaResponse]) -> ()) {
        let headers = AppConfig.shared.authHeader
        
        Alamofire.request(
            AppConfig.shared.apiBaseUrl + "/tipo/diversas?ano=0&mes=0",
            method: .get,
            headers: headers).responseSwiftyJSON{ response in
                
                var resultado = [DiversaResponse]()
                
                response.result.value?.forEach { _, json in
                    var res = DiversaResponse()
                    
                    res.id = UUID(uuidString: json["id"].string!)
                    res.nome = json["nome"].string!
                    
                    resultado.append(res)
                }
                
                callback(resultado)
        }
    }
}
