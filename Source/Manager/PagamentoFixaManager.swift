import Foundation
import CoreData

class PagamentoFixaManager: SincronizadoManager<PagamentoFixa, PagamentoFixaResponse, PagamentoFixaProxy> {
    
    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "data", ascending: true)])
    }
}
