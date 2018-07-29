import Foundation

extension PagamentoCombustivel {
    
    public override var description: String {
        return self.veiculo?.nome ?? ""
    }
}
