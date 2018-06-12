import Foundation

class GrupoManager {
    
    // MARK: - Construtores

    private init() {
    }

    // MARK: - Estáticos

    static func obterTodos() -> [Grupo] {
        return [
            Grupo("fixas", false),
            Grupo("diversas", true),
            Grupo("diaristas", true),
            Grupo("combustiveis", true)
        ]
    }
}
