import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON
import CoreData

struct DiariaResponse {
    
    init() {
    }
    
    var id: UUID!
    
    var valor: Double!
}

class DiariaProxy {
    
    // MARK: - Construtores
    
    private init() {
    }
    
    // MARK: - Estáticos
    
    static func obterTodos(_ callback: @escaping ([DiariaResponse]) -> ()) {
        let headers = AppConfig.shared.authHeader
        
        Alamofire.request(
            AppConfig.shared.apiBaseUrl + "/tipo/diaristas?ano=0&mes=0",
            method: .get,
            headers: headers).responseSwiftyJSON{ response in
                var resultado = [DiariaResponse]()
                
                response.result.value?.forEach { _, json in
                    var res = DiariaResponse()
                    
                    res.id = UUID(uuidString: json["id"].string!)
                    res.valor = json["valor"].double
                    
                    resultado.append(res)
                }
                
                callback(resultado)
        }
    }
}
