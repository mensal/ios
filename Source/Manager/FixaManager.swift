import Foundation
import CoreData
import AlecrimCoreData

class FixaManager: VersionadoManager<Fixa> {
    
    // MARK: - Construtores
    
//    private init() {
//    }
    
    // MARK: - Estáticos
    
//    private static func tabela(_ context: NSManagedObjectContext) -> Table<Fixa> {
//        return Table<Fixa>(context: context)
//    }
    
//    static func obterOuNovo(_ id: UUID, _ context: NSManagedObjectContext) -> Fixa {
//        var resultado = obter(id, context)
//
//        if resultado == nil {
//            resultado = novo(context)
//            resultado!.id = id
//        }
//        
//        return resultado!
//    }
//    
//    static func obter(_ id: UUID, _ context: NSManagedObjectContext) -> Fixa? {
//        return tabela(context).first { _ in NSPredicate(format: "id = %@", id as CVarArg) }
//    }
//    
//    static func novo(_ context: NSManagedObjectContext) -> Fixa {
//        return tabela(context).create()
//    }
    
    static func obterTodos(_ context: NSManagedObjectContext) -> [Fixa] {
        return tabela(context).sort(using: NSSortDescriptor.init(key: "vencimento", ascending: true)).execute()
    }
    
    static func sincronizar() {
        FixaProxy.obterTodos { response in
            let context = persistentContainer.viewContext
            
            response.forEach {
                let persistido = obterOuNovo($0.id ?? UUID(), context)
                persistido.nome = $0.nome
                persistido.vencimento = Int16($0.vencimento)
            }
            
            try? context.save()
        }
    }
}
