import Foundation
import CoreData
import AlecrimCoreData

class SincronizadoManager<E: Versionado, S: VersionadoResponse<E>, P: VersionadoProxy<E, S>>: VersionadoManager<E> {

    // MARK: - Públicos

    func sincronizar(_ context: NSManagedObjectContext, _ completion: (() -> Void)? = nil) {
        let ultimaAtualizacao = obterUltimaAtualizacao(context)
        
        P().obterTodos(apos: ultimaAtualizacao) { resultado in
            resultado.forEach { $0.preenche(self.obterOuNovo($0.id, context), context) }
            completion?()
        }
    }
}
