import Foundation
import CoreData
import AlecrimCoreData

class VersionadoSincronizadoManager<S: VersionadoResponse, P: VersionadoProxy<S>>: VersionadoManager<S.E> {
    
    func sincronizar() {
        P().obterTodos { resultado in
            let context = persistentContainer.viewContext
            resultado.forEach { $0.preenche(self.obterOuNovo($0.id, context)) }
            
            try? context.save()
        }
    }
}
