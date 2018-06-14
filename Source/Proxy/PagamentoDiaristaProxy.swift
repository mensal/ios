import Foundation
import CoreData

class PagamentoDiaristaResponse: PagamentoResponse<PagamentoDiarista> {
    
    override func preenche(_ persistido: PagamentoDiarista, _ context: NSManagedObjectContext) {
        super.preenche(persistido, context)
        persistido.diaria = DiariaManager().obter(tipo.id, context)
    }
}

class PagamentoDiaristaProxy: VersionadoProxy<PagamentoDiarista, PagamentoDiaristaResponse> {
    
    // MARK: - Construtores
    
    required init() {
        super.init("/pagamento/diaristas?ano=2018&mes=6")
    }
}
