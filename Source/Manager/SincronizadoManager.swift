import Foundation
import CoreData
import AlecrimCoreData

class SincronizadoManager<S: VersionadoResponse, P: VersionadoProxy<S>>: VersionadoManager<S.E> {
    
    // MARK: - Públicos

    func sincronizar() {
        P().obterTodos { resultado in
            let context = persistentContainer.viewContext
            resultado.forEach { $0.preenche(self.obterOuNovo($0.id, context)) }
            
            try? context.save()
        }
    }
}
