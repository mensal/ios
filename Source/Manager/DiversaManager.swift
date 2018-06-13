import Foundation
import CoreData
import AlecrimCoreData

class DiversaManager {
    
    // MARK: - Construtores
    
    private init() {
    }
    
    // MARK: - Estáticos
    
    private static func tabela(_ context: NSManagedObjectContext) -> Table<Diversa> {
        return Table<Diversa>(context: context)
    }
    
    static func obterOuNovo(_ id: UUID, _ context: NSManagedObjectContext) -> Diversa {
        var resultado = obter(id, context)

        if resultado == nil {
            resultado = novo(context)
            resultado!.id = id
        }
        
        return resultado!
    }
    
    static func obter(_ id: UUID, _ context: NSManagedObjectContext) -> Diversa? {
        return tabela(context).first { _ in NSPredicate(format: "id = %@", id as CVarArg) }
    }
    
    static func novo(_ context: NSManagedObjectContext) -> Diversa {
        return tabela(context).create()
    }
    
    static func sincronizar(_ context: NSManagedObjectContext) {
        DiversaProxy.obterTodos { response in
            response.forEach { DiversaResponse in
                let persistido = obterOuNovo(DiversaResponse.id ?? UUID(), context)
                persistido.nome = DiversaResponse.nome
            }
            
            try? context.save()
        }
    }
}
