import Foundation
import CoreData

class PagamentoFixaResponse: PagamentoResponse<PagamentoFixa> {
    
    override func preenche(_ persistido: PagamentoFixa, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)
        persistido.fixa = FixaManager().obter(tipo.id, context)
    }
}

class PagamentoFixaProxy: VersionadoProxy<PagamentoFixa, PagamentoFixaResponse> {
    
    // MARK: - Construtores
    
    required init() {
        super.init("/pagamento/fixas?ano=2018&mes=6")
    }
}
