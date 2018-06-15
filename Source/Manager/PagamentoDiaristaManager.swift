import Foundation
import CoreData

class PagamentoDiaristaManager: PagamentoManager<PagamentoDiarista, PagamentoDiaristaResponse, PagamentoDiaristaProxy> {
    
    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "data", ascending: true)])
    }
}
