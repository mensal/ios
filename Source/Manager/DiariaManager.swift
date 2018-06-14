import Foundation
import CoreData
import AlecrimCoreData

class DiariaManager: VersionadoManager<Diaria> {
    
    // MARK: - Construtores
    
//    private init() {
//    }
    
    // MARK: - Estáticos
    
//    private static func tabela(_ context: NSManagedObjectContext) -> Table<Diaria> {
//        return Table<Diaria>(context: context)
//    }
    
//    static func obterOuNovo(_ id: UUID, _ context: NSManagedObjectContext) -> Diaria {
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
//    static func obter(_ id: UUID, _ context: NSManagedObjectContext) -> Diaria? {
//        return tabela(context).first { _ in NSPredicate(format: "id = %@", id as CVarArg) }
//    }
//    
//    private static func novo(_ context: NSManagedObjectContext) -> Diaria {
//        return tabela(context).create()
//    }
    
    static func sincronizar() {
        DiariaProxy.obterTodos { response in
            let context = persistentContainer.viewContext
            
            response.forEach {
                let persistido = obterOuNovo($0.id ?? UUID(), context)
                persistido.valor = $0.valor!
            }
            
            try? context.save()
        }
    }
    
    static func sincronizarPagamentos(_ mes: Mes) {
        DiariaProxy.obterPagamentos(mes) { response in
            
        }
    }
}
