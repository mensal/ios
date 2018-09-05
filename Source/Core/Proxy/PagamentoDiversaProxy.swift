import Foundation
import CoreData
import SwiftyJSON

class PagamentoDiversaRequest: PagamentoRequest<PagamentoDiversa> {
}

class PagamentoDiversaResponse: PagamentoResponse<PagamentoDiversa> {
    var observacao: String

    required init(_ json: JSON) {
        observacao = json["observacao"].stringValue
        super.init(json)
    }

    override func preenche(_ persistido: PagamentoDiversa, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)

        persistido.observacao = observacao
        persistido.diversa    = DiversaManager().obter(tipo.id, context)
    }
}

class PagamentoDiversaProxy: PagamentoProxy<PagamentoDiversa, PagamentoDiversaRequest, PagamentoDiversaResponse> {

    // MARK: - Construtores

    required init() {
        super.init("/pagamento/diversas")
    }
}
