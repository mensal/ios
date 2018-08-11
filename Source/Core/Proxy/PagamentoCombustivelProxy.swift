import Foundation
import CoreData

class PagamentoCombustivelRequest: PagamentoRequest<PagamentoCombustivel> {
}

class PagamentoCombustivelResponse: PagamentoResponse<PagamentoCombustivel> {

    override func preenche(_ persistido: PagamentoCombustivel, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)
        persistido.veiculo = VeiculoManager().obter(tipo.id, context)
    }
}

class PagamentoCombustivelProxy: PagamentoProxy<PagamentoCombustivel, PagamentoCombustivelRequest, PagamentoCombustivelResponse> {

    // MARK: - Construtores

    required init() {
        super.init("/pagamento/combustiveis")
    }
}
