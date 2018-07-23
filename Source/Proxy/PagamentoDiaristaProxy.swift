import Foundation
import CoreData

class PagamentoDiaristaRequest: PagamentoRequest<PagamentoDiarista> {
}

class PagamentoDiaristaResponse: PagamentoResponse<PagamentoDiarista> {

    override func preenche(_ persistido: PagamentoDiarista, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)
        persistido.diaria = DiariaManager().obter(tipo.id, context)
    }
}

class PagamentoDiaristaProxy: PagamentoProxy<PagamentoDiarista, PagamentoDiaristaRequest, PagamentoDiaristaResponse> {

    // MARK: - Construtores

    required init() {
        super.init("/pagamento/diaristas")
    }
}
