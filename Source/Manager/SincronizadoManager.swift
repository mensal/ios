import Foundation
import CoreData

class SincronizadoManager<E: Versionado, Q: VersionadoRequest<E>, S: VersionadoResponse<E>, P: VersionadoProxy<E, Q, S>>: VersionadoManager<E> {

    // MARK: - Públicos

    func sincronizar(_ delegate: AutenticacaoDelegate, _ context: NSManagedObjectContext, _ completion: (() -> Void)? = nil) {
        let ultimaAtualizacao = obterUltimaAtualizacao(context)

        let proxy = P()
        proxy.autenticacaoDelegate = delegate

        proxy.obterTodos(apos: ultimaAtualizacao) { resultado in
            resultado.forEach {
                self.atualizarLocal($0, context)
            }

            self.obterExcluidos(context).forEach {
                self.excluirRemoto($0, delegate, context)
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

    private func excluirRemoto(_ persistido: E, _ delegate: AutenticacaoDelegate, _ context: NSManagedObjectContext) {
        let proxy = P()
        proxy.autenticacaoDelegate = delegate

        proxy.excluir(persistido) { response in
            let persistido = self.obterOuNovo(response.id, context)
            response.preenche(persistido, context)
        }
    }
}
