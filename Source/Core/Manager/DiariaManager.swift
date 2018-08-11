import Foundation
import CoreData

class DiariaManager: SincronizadoManager<Diaria, DiariaRequest, DiariaResponse, DiariaProxy> {

    // MARK: - Construtores

    init() {
        super.init([NSSortDescriptor(key: "valor", ascending: true)])
    }
}
