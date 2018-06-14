import Foundation
import CoreData
import AlecrimCoreData

class UsuarioManager: SincronizadoManager<UsuarioResponse, UsuarioProxy> {

    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "nome", ascending: true)])
    }
}
