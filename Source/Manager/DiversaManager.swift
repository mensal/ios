import Foundation
import CoreData

class DiversaManager: SincronizadoManager<DiversaResponse, DiversaProxy> {

    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "nome", ascending: true)])
    }
}
