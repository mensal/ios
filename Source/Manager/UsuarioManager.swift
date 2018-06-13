import Foundation
import CoreData
import AlecrimCoreData

class UsuarioManager {
    
    // MARK: - Construtores
    
    private init() {
    }
    
    // MARK: - Estáticos
    
    private static func tabela(_ context: NSManagedObjectContext) -> Table<Usuario> {
        return Table<Usuario>(context: context)
    }
    
    static func obterOuNovo(_ id: UUID, _ context: NSManagedObjectContext) -> Usuario {
        let resultado = obter(id, context)
        return resultado != nil ? resultado! : novo(context)
    }

    static func obter(_ id: UUID, _ context: NSManagedObjectContext) -> Usuario? {
        return tabela(context).first { _ in NSPredicate(format: "id = %@", id as CVarArg) }
    }

    static func novo(_ context: NSManagedObjectContext) -> Usuario {
        return tabela(context).create()
    }
    
    static func sincronizar(_ context: NSManagedObjectContext) {
        UsuarioProxy.obterTodos { response in
            response.forEach { usuarioResponse in
                let persistido = obterOuNovo(usuarioResponse.id ?? UUID(), context)
                persistido.nome = usuarioResponse.nome
            }
        }
    }
}
