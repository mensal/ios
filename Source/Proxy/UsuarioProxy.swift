import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON
import CoreData

struct UsuarioResponse {
    
    init() {
    }
    
    var id: UUID!
    
    var nome: String!
}

class UsuarioProxy {
    
    // MARK: - Construtores
    
    private init() {
    }
    
    // MARK: - Estáticos
    
    static func obterTodos(_ callback: @escaping ([UsuarioResponse]) -> ()) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjZWE4ZGMxNC0zZmJmLTQyOGUtODgxMi05NjY5NGEwMzFkZjMiLCJuYW1lIjoiQ2xldmVyc29uIiwiaXNzIjoiaHR0cDovL3Rlc3RlIiwiZXhwIjoxNTI5MzI0NTYzLCJpYXQiOjE1Mjg4OTI1NjN9.Bxp0US3oymocVf310y71rqpWjO8CoOiTUSs190cQOZRvUeTLyFjQHzd1xuiaeWf0SvTleijmKIfvDoTaoAKHXg"
        ]
        
        Alamofire.request(
            "https://despesas-despesas.a3c1.starter-us-west-1.openshiftapps.com/api/usuarios",
            method: .get,
            headers: headers).responseSwiftyJSON{ response in
                var resultado = [UsuarioResponse]()
                
                response.result.value?.forEach { _, json in
                    var usuario = UsuarioResponse()

                    usuario.id = UUID(uuidString: json["id"].string!)
                    usuario.nome = json["nome"].string!
                    
                    resultado.append(usuario)
                }
                
                callback(resultado)
        }
    }
}
