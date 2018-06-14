import Foundation
import CoreData

class PagamentoCombustivelManager: SincronizadoManager<PagamentoCombustivel, PagamentoCombustivelResponse, PagamentoCombustivelProxy> {
    
    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "data", ascending: true)])
    }
    
    //    func obter(_ mes: Mes, _ context: NSManagedObjectContext) -> E? {
    //        return tabela(context).first { _ in NSPredicate(format: "id = %@", id as CVarArg) }
    //        tabela(context).filter { _ in NSPredicate(format: "id = %@", id as CVarArg) }
    //    }
}
