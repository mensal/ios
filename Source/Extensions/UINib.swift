import UIKit

extension UINib {

    // MARK: - Conveniência

    static var mesHeader: UINib {
        return UINib(nibName: "MesHeader", bundle: nil)
    }

    static var rateioCell: UINib {
        return UINib(nibName: "RateioCell", bundle: nil)
    }
    
    func instantiate<T>() -> T? {
        return self.instantiate(withOwner: nil, options: nil).first as? T
    }
}
