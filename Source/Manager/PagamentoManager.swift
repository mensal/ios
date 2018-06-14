//import Foundation
//import CoreData
//import AlecrimCoreData
//
//class PagamentoManager {
//    
//    // MARK: - Construtores
//    
//    private init() {
//    }
//    
//    // MARK: - Estáticos
//    
//    static func obter(_ grupoId: GrupoId, _ mes: Mes, _ context: NSManagedObjectContext) -> [Pagamento] {
//        return [Pagamento]()
//    }
//    
////    static func sincronizar(_ grupoId: GrupoId, _ mes: Mes) {
////        PagamentoProxy.obter(grupoId, mes) { response in
////            let context = persistentContainer.viewContext
////
//////            response.forEach {
//////                let persistido = obterOuNovo($0.id ?? UUID(), context)
//////                persistido.nome = $0.nome
//////                persistido.vencimento = Int16($0.vencimento)
//////            }
////
////            try? context.save()
////        }
////    }
//}
