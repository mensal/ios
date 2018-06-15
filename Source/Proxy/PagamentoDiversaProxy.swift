import Foundation
import CoreData

class PagamentoDiversaResponse: PagamentoResponse<PagamentoDiversa> {
    
    override func preenche(_ persistido: PagamentoDiversa, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)
        persistido.diversa = DiversaManager().obter(tipo.id, context)
    }
}

class PagamentoDiversaProxy: PagamentoProxy<PagamentoDiversa, PagamentoDiversaResponse> {
    
    // MARK: - Construtores
    
    required init() {
        super.init("/pagamento/diversas?ano=2018&mes=6")
    }
}
