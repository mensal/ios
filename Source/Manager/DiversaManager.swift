import Foundation
import CoreData

class DiversaManager: SincronizadoManager<Diversa, DiversaRequest, DiversaResponse, DiversaProxy> {

    // MARK: - Construtores

    init() {
        super.init([NSSortDescriptor(key: "nome", ascending: true)])
    }
}
