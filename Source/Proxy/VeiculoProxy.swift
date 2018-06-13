import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON
import CoreData

struct VeiculoResponse {
    
    init() {
    }
    
    var id: UUID!
    
    var nome: String!
}

class VeiculoProxy {
    
    // MARK: - Construtores
    
    private init() {
    }
    
    // MARK: - Estáticos
    
    static func obterTodos(_ callback: @escaping ([VeiculoResponse]) -> ()) {
        let headers = AppConfig.shared.authHeader
        
        Alamofire.request(
            AppConfig.shared.apiBaseUrl + "/tipo/combustiveis?ano=0&mes=0",
            method: .get,
            headers: headers).responseSwiftyJSON{ response in
                var resultado = [VeiculoResponse]()
                
                response.result.value?.forEach { _, json in
                    var res = VeiculoResponse()
                    
                    res.id = UUID(uuidString: json["id"].string!)
                    res.nome = json["veiculo"].string!
                    
                    resultado.append(res)
                }
                
                callback(resultado)
        }
    }
}
