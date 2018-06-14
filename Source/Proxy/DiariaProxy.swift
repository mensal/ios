import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

class DiariaResponse {
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
                    let res = DiariaResponse()
                    
                    res.id = UUID(uuidString: json["id"].string!)
                    res.valor = json["valor"].double
                    
                    resultado.append(res)
                }
                
                callback(resultado)
        }
    }
    
    static func obterPagamentos(_ mes: Mes, _ callback: @escaping ([PagamentoResponse]) -> ()) {
        let headers = AppConfig.shared.authHeader
        //
        Alamofire.request(
            AppConfig.shared.apiBaseUrl + "/pagamento/diaristas?ano=\(mes.ano!)&mes=\(mes.ordinal!)",
            method: .get,
            headers: headers).responseSwiftyJSON{ response in
                let resultado = [PagamentoResponse]()
                
                print(response)
                //
                //                response.result.value?.forEach { _, json in
                //                    var res = VeiculoResponse()
                //
                //                    res.id = UUID(uuidString: json["id"].string!)
                //                    res.nome = json["veiculo"].string!
                //
                //                    resultado.append(res)
                //                }
                //
                callback(resultado)
        }
    }
}
