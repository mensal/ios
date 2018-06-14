import Foundation
import CoreData

class DiversaManager: VersionadoSincronizadoManager<DiversaResponse, DiversaProxy> {

    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "nome", ascending: true)])
    }

    // MARK: - Declarados
    
//    func sincronizar() {
//        DiversaProxy().obterTodos { response in
//            let context = persistentContainer.viewContext
//            
//            response.forEach {
//                let persistido = self.obterOuNovo($0.id, context)
//                persistido.nome = $0.nome
//            }
//            
//            try? context.save()
//        }
//    }
}
