import Foundation
import CoreData

class SincronizadoManager<E: Versionado, S: VersionadoResponse<E>, P: VersionadoProxy<E, S>>: VersionadoManager<E> {

    // MARK: - Públicos

    func sincronizar(_ context: NSManagedObjectContext, _ completion: (() -> Void)? = nil) {
        let ultimaAtualizacao = obterUltimaAtualizacao(context)

        P().obterTodos(apos: ultimaAtualizacao) { resultado in
            resultado.forEach {
                self.atualizarLocal($0, context)
            }

            self.obterExcluidos(context).forEach {
                self.excluirRemoto($0, context)
            }

            completion?()
        }
    }

    // MARK: - Privados

    private func atualizarLocal(_ response: S, _ context: NSManagedObjectContext) {
        let persistido = self.obterOuNovo(response.id, context)

        if persistido.atualizacaoLocalEm ?? Date.distantPast < response.atualizacaoRemotaEm ?? Date.distantFuture {
            if persistido is Pagamento {
                RateioManager().excluirTodos(persistido as! Pagamento, context)
            }

            response.preenche(persistido, context)
        }
    }

    private func excluirRemoto(_ persistido: E, _ context: NSManagedObjectContext) {
    }
}
