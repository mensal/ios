import Foundation
import CoreData

class DiariaManager: VersionadoSincronizadoManager<DiariaResponse, DiariaProxy> {

    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "valor", ascending: true)])
    }

    // MARK: - Declarados
    
//    func sincronizar() {
//        DiariaProxy().obterTodos { response in
//            let context = persistentContainer.viewContext
//            
//            response.forEach {
//                let persistido = self.obterOuNovo($0.id, context)
//                persistido.valor = $0.valor
//            }
//            
//            try? context.save()
//        }
//    }
    
//    func sincronizarPagamentos(_ mes: Mes) {
//        DiariaProxy().obterPagamentos(mes) { response in
//
//        }
//    }
}
