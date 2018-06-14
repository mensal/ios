import Foundation
import CoreData

class VeiculoManager: SincronizadoManager<Veiculo, VeiculoResponse, VeiculoProxy> {
    
    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "nome", ascending: true)])
    }
}
