import Foundation
import SwiftyJSON

class PagamentoFixaResponse: PagamentoResponse<PagamentoFixa> {
    
    override func preenche(_ persistido: PagamentoFixa) {
        super.preenche(persistido)
        let context = persistentContainer.viewContext
        
        persistido.fixa = FixaManager().obter(self.tipo.id, context)
    }
}

class PagamentoFixaProxy: VersionadoProxy<PagamentoFixa, PagamentoFixaResponse> {
    
    // MARK: - Construtores
    
    required init() {
        super.init("/pagamento/fixas?ano=2018&mes=6")
    }
}
