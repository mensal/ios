import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON
import CoreData

class UsuarioResponse {
    var id: UUID!
    var nome: String!
}

class UsuarioProxy {
    
    // MARK: - Construtores
    
    private init() {
    }
    
    // MARK: - Estáticos
    
    static func obterTodos(_ callback: @escaping ([UsuarioResponse]) -> ()) {
        let headers = AppConfig.shared.authHeader
        
        Alamofire.request(
            AppConfig.shared.apiBaseUrl + "/usuarios",
            method: .get,
            headers: headers).responseSwiftyJSON{ response in
                var resultado = [UsuarioResponse]()
                
                response.result.value?.forEach { _, json in
                    let usuario = UsuarioResponse()

                    usuario.id = UUID(uuidString: json["id"].string!)
                    usuario.nome = json["nome"].string!
                    
                    resultado.append(usuario)
                }
                
                callback(resultado)
        }
    }
}
