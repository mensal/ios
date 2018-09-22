import Foundation
import Localize_Swift

enum GrupoId: String {
    case fixas
    case diversas
    case combustiveis
    case diaristas
}

class Grupo {

    // MARK: - Propriedades

    var id: GrupoId?

    var dinamico: Bool?

    var nomeSingular: String? {
        //        get {
        return id == nil ? nil : (id!.rawValue + "Singular").localized()
        //        }
    }

    var nomePlural: String? {
        //        get {
        return id == nil ? nil : id!.rawValue.localized()
        //        }
    }

    // MARK: - Construtores

    init(_ id: GrupoId, _ dinamico: Bool?) {
        self.id = id
        self.dinamico = dinamico
    }
}
