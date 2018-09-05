import Foundation
import CoreData

class DatabaseExporter {

    // MARK: - Construtores

    private init() {
    }

    // MARK: - Públicos

    static func exportar(_ context: NSManagedObjectContext) -> Data {
        var sql = ""

        UsuarioManager().obterTodos(context).forEach {
            if let id = $0.id, let atualizacaoRemotaEm = $0.atualizacaoRemotaEm {
                sql += "INSERT INTO usuario (id, email, nome, atualizado_em, excluido_em) VALUES ('\(id)', '\($0.email ?? "")', '\($0.nome ?? "")', '\(atualizacaoRemotaEm.iso8601Extended)', null);\n"
            }
        }

        sql += "\n"

        VeiculoManager().obterTodos(context).forEach {
            if let id = $0.id, let atualizacaoRemotaEm = $0.atualizacaoRemotaEm {
                sql += "INSERT INTO tipo_despesa (id, atualizado_em, excluido_em) VALUES ('\(id)', '\(atualizacaoRemotaEm.iso8601Extended)', null);\n"
                sql += "INSERT INTO tipo_despesa_combustivel (veiculo, id) VALUES ('\($0.nome ?? "")', '\(id)');\n"
            }
        }

        DiariaManager().obterTodos(context).forEach {
            if let id = $0.id, let atualizacaoRemotaEm = $0.atualizacaoRemotaEm {
                sql += "INSERT INTO tipo_despesa (id, atualizado_em, excluido_em) VALUES ('\(id)', '\(atualizacaoRemotaEm.iso8601Extended)', null);\n"
                sql += "INSERT INTO tipo_despesa_diarista (valor, id) VALUES (\($0.valor), '\(id)');\n"
            }
        }

        DiversaManager().obterTodos(context).forEach {
            if let id = $0.id, let atualizacaoRemotaEm = $0.atualizacaoRemotaEm {
                sql += "INSERT INTO tipo_despesa (id, atualizado_em, excluido_em) VALUES ('\(id)', '\(atualizacaoRemotaEm.iso8601Extended)', null);\n"
                sql += "INSERT INTO tipo_despesa_diversa (nome, id) VALUES ('\($0.nome ?? "")', '\(id)');\n"
            }
        }

        FixaManager().obterTodos(context).forEach {
            if let id = $0.id, let atualizacaoRemotaEm = $0.atualizacaoRemotaEm {
                sql += "INSERT INTO tipo_despesa (id, atualizado_em, excluido_em) VALUES ('\(id)', '\(atualizacaoRemotaEm.iso8601Extended)', null);\n"
                sql += "INSERT INTO tipo_despesa_fixa (nome, vencimento, id) VALUES ('\($0.nome ?? "")', \($0.vencimento), '\(id)');\n"
            }
        }

        sql += "\n"

        PagamentoManager([]).obterTodos(context).forEach {
            if let id = $0.id, let atualizacaoRemotaEm = $0.atualizacaoRemotaEm {
                sql += "INSERT INTO pagamento (id, atualizado_em, data, excluido_em) VALUES ('\(id)', '\(atualizacaoRemotaEm.iso8601Extended)', '\($0.data?.iso8601Date ?? "")', null);\n"
            }
        }

        sql += "\n"

        PagamentoDiaristaManager().obterTodos(context).forEach {
            if let id = $0.id {
                sql += "INSERT INTO pagamento_diarista (id, id_tipo) VALUES ('\(id)', '\($0.diaria!.id!)');\n"
            }
        }

        PagamentoCombustivelManager().obterTodos(context).forEach {
            if let id = $0.id {
                sql += "INSERT INTO pagamento_combustivel (litros, odometro, id, id_tipo) VALUES (\($0.litro), \($0.odometro), '\(id)', '\($0.veiculo!.id!)');\n"
            }
        }

        PagamentoDiversaManager().obterTodos(context).forEach {
            if let id = $0.id {
                sql += "INSERT INTO pagamento_diversa (observacao, id, id_tipo) VALUES ('\($0.observacao ?? "")', '\(id)', '\($0.diversa!.id!)');\n"
            }
        }

        PagamentoFixaManager().obterTodos(context).forEach {
            if let id = $0.id {
                sql += "INSERT INTO pagamento_fixa (id, id_tipo) VALUES ('\(id)', '\($0.fixa!.id!)');\n"
            }
        }

        sql += "\n"

        RateioManager().obterTodos(context).forEach {
            sql += "INSERT INTO usuario_pagamento (id_pagamento, id_usuario, valor) VALUES ('\($0.pagamento!.id!)', '\($0.usuario!.id!)', \($0.valor));\n"
        }

        return sql.data(using: .utf8)!
    }
}
