//MARK: - convertDateFormatter
import Foundation
extension String {
    static func convertDateFormatter(date: String) -> (String, String) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        guard let date = dateFormatter.date(from: date) else {return ("","")}

        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dateStamp = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: date)
        
        return (dateStamp, timeStamp)
    }
}
