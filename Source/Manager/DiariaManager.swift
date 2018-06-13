import Foundation
import CoreData
import AlecrimCoreData

class DiariaManager {
    
    // MARK: - Construtores
    
    private init() {
    }
    
    // MARK: - Estáticos
    
    private static func tabela(_ context: NSManagedObjectContext) -> Table<Diaria> {
        return Table<Diaria>(context: context)
    }
    
    static func obterOuNovo(_ id: UUID, _ context: NSManagedObjectContext) -> Diaria {
        let resultado = obter(id, context)
        return resultado != nil ? resultado! : novo(context)
    }
    
    static func obter(_ id: UUID, _ context: NSManagedObjectContext) -> Diaria? {
        return tabela(context).first { _ in NSPredicate(format: "id = %@", id as CVarArg) }
    }
    
    static func novo(_ context: NSManagedObjectContext) -> Diaria {
        return tabela(context).create()
    }
    
    static func sincronizar(_ context: NSManagedObjectContext) {
        DiariaProxy.obterTodos { response in
            response.forEach { DiariaResponse in
                let persistido = obterOuNovo(DiariaResponse.id ?? UUID(), context)
                persistido.valor = DiariaResponse.valor!
            }
        }
    }
}
