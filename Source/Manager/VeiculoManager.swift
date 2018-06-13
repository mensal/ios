import Foundation
import CoreData
import AlecrimCoreData

class VeiculoManager {
    
    // MARK: - Construtores
    
    private init() {
    }
    
    // MARK: - Estáticos
    
    private static func tabela(_ context: NSManagedObjectContext) -> Table<Veiculo> {
        return Table<Veiculo>(context: context)
    }
    
    static func obterOuNovo(_ id: UUID, _ context: NSManagedObjectContext) -> Veiculo {
        var resultado = obter(id, context)

        if resultado == nil {
            resultado = novo(context)
            resultado!.id = id
        }
        
        return resultado!
    }
    
    static func obter(_ id: UUID, _ context: NSManagedObjectContext) -> Veiculo? {
        return tabela(context).first { _ in NSPredicate(format: "id = %@", id as CVarArg) }
    }
    
    static func novo(_ context: NSManagedObjectContext) -> Veiculo {
        return tabela(context).create()
    }
    
    static func sincronizar() {
        VeiculoProxy.obterTodos { response in
            let context = persistentContainer.viewContext
            
            response.forEach {
                let persistido = obterOuNovo($0.id ?? UUID(), context)
                persistido.nome = $0.nome
            }
            
            try? context.save()
        }
    }
}
