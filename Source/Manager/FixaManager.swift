import Foundation
import CoreData

class FixaManager: SincronizadoManager<Fixa, FixaResponse, FixaProxy> {
    
    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "vencimento", ascending: true), NSSortDescriptor(key: "nome", ascending: true)])
    }

    // MARK: - Públicos
    
    func obterPagamentos(_ mes: Mes, _ context: NSManagedObjectContext) -> [Pagamento] {
        return [Pagamento]()
    }
}
