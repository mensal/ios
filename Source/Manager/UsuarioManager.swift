import Foundation
import CoreData
import AlecrimCoreData

class UsuarioManager: SincronizadoManager<Usuario, UsuarioRequest, UsuarioResponse, UsuarioProxy> {

    // MARK: - Construtores

    init() {
        super.init([NSSortDescriptor(key: "nome", ascending: true)])
    }
}
