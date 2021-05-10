import UIKit

extension String {
    func formatApiDate() -> String? {
        let inputFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .autoupdatingCurrent
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = inputFormat
        
        guard let date = dateFormatter.date(from: self) else { return nil}
        let outputFormat = "MMM dd"
        dateFormatter.dateFormat = outputFormat
        return dateFormatter.string(from: date)
    }
}
