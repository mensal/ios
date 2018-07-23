import Foundation
import CoreData

class VeiculoManager: SincronizadoManager<Veiculo, VeiculoRequest, VeiculoResponse, VeiculoProxy> {

    // MARK: - Construtores

    init() {
        super.init([NSSortDescriptor(key: "nome", ascending: true)])
    }
}
