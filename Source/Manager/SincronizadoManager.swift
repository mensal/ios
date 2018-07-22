import Foundation
import CoreData
//import AlecrimCoreData

class SincronizadoManager<E: Versionado, S: VersionadoResponse<E>, P: VersionadoProxy<E, S>>: VersionadoManager<E> {

    // MARK: - Públicos

    func sincronizar(_ context: NSManagedObjectContext, _ completion: (() -> Void)? = nil) {
        let ultimaAtualizacao = obterUltimaAtualizacao(context)

        P().obterTodos(apos: ultimaAtualizacao) { resultado in
            resultado.forEach {
                let persistido = self.obterOuNovo($0.id, context)

                if $0.excluidoEm != nil {
                    self.excluirLocal(persistido, $0, context)
                } else if persistido.atualizacaoLocalEm ?? Date.distantPast < $0.atualizacaoRemotaEm! {
                    self.atualizarLocal(persistido, $0, context)
                }
            }

            self.obterExcluidos(context).forEach {
                self.excluirRemoto($0, context)
            }

            completion?()
        }
    }

    private func excluirLocal(_ persistido: E, _ response: S, _ context: NSManagedObjectContext) {
        self.excluir(persistido, modo: .fisica, context)
    }

    private func atualizarLocal(_ persistido: E, _ response: S, _ context: NSManagedObjectContext) {
        if persistido is Pagamento {
            RateioManager().excluirTodos(persistido as! Pagamento, context)
        }

        response.preenche(self.obterOuNovo(response.id, context), context)
    }

    private func excluirRemoto(_ persistido: E, _ context: NSManagedObjectContext) {
    }
}
