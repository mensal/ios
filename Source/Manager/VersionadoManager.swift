import Foundation
import CoreData
import AlecrimCoreData

class VersionadoManager<E: Versionado> {
 
    private init() {
    }
    
    static func tabela(_ context: NSManagedObjectContext) -> Table<E> {
        return Table<E>(context: context)
    }
    
    static func obterOuNovo(_ id: UUID, _ context: NSManagedObjectContext) -> E {
        var resultado = obter(id, context)
        
        if resultado == nil {
            resultado = novo(context)
            resultado!.id = id
        }
        
        return resultado!
    }
    
    static func obter(_ id: UUID, _ context: NSManagedObjectContext) -> E? {
        return tabela(context).first { _ in NSPredicate(format: "id = %@", id as CVarArg) }
    }
    
    private static func novo(_ context: NSManagedObjectContext) -> E {
        return tabela(context).create()
    }
}
