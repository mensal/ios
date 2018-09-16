import Foundation

extension String {

    public func padding<T>(toLength newLength: Int, withPad padString: T) -> String where T: StringProtocol {
        let reversed = String(self.reversed())
        let reversedPadded = reversed.padding(toLength: newLength, withPad: padString, startingAt: 0)

        return String(reversedPadded.reversed())
    }
}
