import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

struct PagamentoResponse {
    init() { }
    var id: UUID!
    var nome: String!
}

class PagamentoProxy {
    
    // MARK: - Construtores
    
    private init() {
    }
    
    // MARK: - Estáticos

    static func obter(_ grupo: Grupo, _ mes: Mes, _ callback: @escaping ([PagamentoResponse]) -> ()) {
        let headers = AppConfig.shared.authHeader
//
        Alamofire.request(
            AppConfig.shared.apiBaseUrl + "/pagamento/\(grupo.id!)?ano=\(mes.ano!)&mes=\(mes.ordinal!)",
            method: .get,
            headers: headers).responseSwiftyJSON{ response in
                var resultado = [PagamentoResponse]()
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
