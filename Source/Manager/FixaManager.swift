import Foundation
import CoreData

class FixaManager: SincronizadoManager<FixaResponse, FixaProxy> {
    
    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "vencimento", ascending: true)])
    }

    // MARK: - Declarados
    
    func obterPagamentos(_ mes: Mes, _ context: NSManagedObjectContext) -> [Pagamento] {
        return [Pagamento]()
    }
}
