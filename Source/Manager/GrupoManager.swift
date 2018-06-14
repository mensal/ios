import Foundation

class GrupoManager {
    
    // MARK: - Construtores
    
    private static let grupos = [
        Grupo(.fixas, false),
        Grupo(.diversas, true),
        Grupo(.diaristas, true),
        Grupo(.combustiveis, true)
    ]

    private init() {
    }

    // MARK: - Estáticos

    static func obterTodos() -> [Grupo] {
        return grupos
    }
    
    static func obter(_ id: GrupoId) -> Grupo {
        return obterTodos().first(where: { $0.id == id } )!
    }
}
