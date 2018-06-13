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
        let headers: HTTPHeaders = [
            "Authorization": "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjZWE4ZGMxNC0zZmJmLTQyOGUtODgxMi05NjY5NGEwMzFkZjMiLCJuYW1lIjoiQ2xldmVyc29uIiwiaXNzIjoiaHR0cDovL3Rlc3RlIiwiZXhwIjoxNTI5MzI0NTYzLCJpYXQiOjE1Mjg4OTI1NjN9.Bxp0US3oymocVf310y71rqpWjO8CoOiTUSs190cQOZRvUeTLyFjQHzd1xuiaeWf0SvTleijmKIfvDoTaoAKHXg"
        ]
        
        Alamofire.request(
            "https://despesas-despesas.a3c1.starter-us-west-1.openshiftapps.com/api/tipo/diaristas?ano=0&mes=0",
            method: .get,
            headers: headers).responseSwiftyJSON{ response in
                var resultado = [DiariaResponse]()
                
                response.result.value?.forEach { _, json in
                    var Diaria = DiariaResponse()
                    
                    Diaria.id = UUID(uuidString: json["id"].string!)
                    Diaria.valor = json["valor"].double
                    
                    resultado.append(Diaria)
                }
                
                callback(resultado)
        }
    }
}
