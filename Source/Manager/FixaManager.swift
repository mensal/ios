import Foundation
import CoreData
import AlecrimCoreData

class FixaManager {
    
    // MARK: - Construtores
    
    private init() {
    }
    
    // MARK: - Estáticos
    
    private static func tabela(_ context: NSManagedObjectContext) -> Table<Fixa> {
        return Table<Fixa>(context: context)
    }
    
    static func obterOuNovo(_ id: UUID, _ context: NSManagedObjectContext) -> Fixa {
        var resultado = obter(id, context)

        if resultado == nil {
            resultado = novo(context)
            resultado!.id = id
        }
        
        return resultado!
    }
    
    static func obter(_ id: UUID, _ context: NSManagedObjectContext) -> Fixa? {
        return tabela(context).first { _ in NSPredicate(format: "id = %@", id as CVarArg) }
    }
    
    static func novo(_ context: NSManagedObjectContext) -> Fixa {
        return tabela(context).create()
    }
    
    static func sincronizar(_ context: NSManagedObjectContext) {
        FixaProxy.obterTodos { response in
            response.forEach { FixaResponse in
                let persistido = obterOuNovo(FixaResponse.id ?? UUID(), context)
                persistido.nome = FixaResponse.nome
            }
            
            try? context.save()
        }
    }
}
