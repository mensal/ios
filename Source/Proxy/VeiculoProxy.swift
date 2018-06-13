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
        let headers: HTTPHeaders = [
            "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjZWE4ZGMxNC0zZmJmLTQyOGUtODgxMi05NjY5NGEwMzFkZjMiLCJuYW1lIjoiQ2xldmVyc29uIiwiaXNzIjoiaHR0cDovL3Rlc3RlIiwiZXhwIjoxNTI5MzI0NTYzLCJpYXQiOjE1Mjg4OTI1NjN9.Bxp0US3oymocVf310y71rqpWjO8CoOiTUSs190cQOZRvUeTLyFjQHzd1xuiaeWf0SvTleijmKIfvDoTaoAKHXg"
        ]
        
        Alamofire.request(
            "https://despesas-despesas.a3c1.starter-us-west-1.openshiftapps.com/api/tipo/combustiveis?ano=0&mes=0",
            method: .get,
            headers: headers).responseSwiftyJSON{ response in
                var resultado = [VeiculoResponse]()
                
                response.result.value?.forEach { _, json in
                    var Veiculo = VeiculoResponse()
                    
                    Veiculo.id = UUID(uuidString: json["id"].string!)
                    Veiculo.nome = json["veiculo"].string!
                    
                    resultado.append(Veiculo)
                }
                
                callback(resultado)
        }
    }
}
