import Foundation
import CoreData
import AlecrimCoreData

class UsuarioManager: VersionadoSincronizadoManager<UsuarioResponse, UsuarioProxy> {

    // MARK: - Construtores
    
    init() {
        super.init([NSSortDescriptor(key: "nome", ascending: true)])
    }

    // MARK: - Declarados
    
//    func sincronizar() {
//        UsuarioProxy().obterTodos { response in
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
