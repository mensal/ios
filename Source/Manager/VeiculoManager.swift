import Foundation
import CoreData

class VeiculoManager: SincronizadoManager<VeiculoResponse, VeiculoProxy> {
    
    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "nome", ascending: true)])
    }
}
