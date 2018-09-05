import Foundation
import CoreData
import SwiftyJSON

class PagamentoCombustivelRequest: PagamentoRequest<PagamentoCombustivel> {
}

class PagamentoCombustivelResponse: PagamentoResponse<PagamentoCombustivel> {
    var litros: Double
    var odometro: Int32

    required init(_ json: JSON) {
        litros   = json["litros"].doubleValue
        odometro = json["odometro"].int32Value

        super.init(json)
    }

    override func preenche(_ persistido: PagamentoCombustivel, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)

        persistido.litro    = litros
        persistido.odometro = odometro
        persistido.veiculo  = VeiculoManager().obter(tipo.id, context)
    }
}

class PagamentoCombustivelProxy: PagamentoProxy<PagamentoCombustivel, PagamentoCombustivelRequest, PagamentoCombustivelResponse> {

    // MARK: - Construtores

    required init() {
        super.init("/pagamento/combustiveis")
    }
}
