import Foundation
import CoreData

class DiariaManager: SincronizadoManager<Diaria, DiariaResponse, DiariaProxy> {

    // MARK: - Construtores

    init() {
        super.init([NSSortDescriptor(key: "valor", ascending: true)])
    }
}
