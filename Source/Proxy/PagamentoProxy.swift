import Foundation
import SwiftyJSON

class PagamentoResponse {
    var id: UUID!
    var nome: String!
    var tipo: IdResponse!
    var valores: [RateioResponse]!
}

class IdResponse {
    var id: UUID!
}

class RateioResponse {
    var valor: Double!
    var usuario: IdResponse!
}

class PagamentoProxy {
    
    // MARK: - Construtores
    
//    private init() {
//    }
    
    // MARK: - Estáticos

//    static func obter(_ grupoId: GrupoId, _ mes: Mes, _ callback: @escaping ([PagamentoResponse]) -> ()) {
//        let headers = AppConfig.shared.authHeader
////
//        Alamofire.request(
//            AppConfig.shared.apiBaseUrl + "/pagamento/\(grupoId.rawValue)?ano=\(mes.ano!)&mes=\(mes.ordinal!)",
//            method: .get,
//            headers: headers).responseSwiftyJSON{ response in
//                let resultado = [PagamentoResponse]()
//
//                print(response)
////
////                response.result.value?.forEach { _, json in
////                    var res = VeiculoResponse()
////
////                    res.id = UUID(uuidString: json["id"].string!)
////                    res.nome = json["veiculo"].string!
////
////                    resultado.append(res)
////                }
////
//                callback(resultado)
//        }
//    }
}
