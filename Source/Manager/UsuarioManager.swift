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
        var resultado = obter(id, context)
        
        if resultado == nil {
            resultado = novo(context)
            resultado!.id = id
        }
        
        return resultado!
    }

    static func obter(_ id: UUID, _ context: NSManagedObjectContext) -> Usuario? {
        return tabela(context).first { _ in NSPredicate(format: "id = %@", id as CVarArg) }
    }

    static func novo(_ context: NSManagedObjectContext) -> Usuario {
        return tabela(context).create()
    }
    
    static func sincronizar(_ context: NSManagedObjectContext) {
        UsuarioProxy.obterTodos { response in
            response.forEach { res in
                let persistido = obterOuNovo(res.id ?? UUID(), context)
                persistido.nome = res.nome
            }
            
            try? context.save()
        }
    }
}
