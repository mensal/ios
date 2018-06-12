import Foundation
import Localize_Swift

class Grupo {
    
    // MARK: - Propriedades
    
    var id: String?
    
    var dinamico: Bool?
    
    var nome: String? {
        get {
            return id == nil ? nil : id!.localized()
        }
    }
    
    // MARK: - Construtores
    
    init(_ id: String?, _ dinamico: Bool?) {
        self.id = id
        self.dinamico = dinamico
    }
}