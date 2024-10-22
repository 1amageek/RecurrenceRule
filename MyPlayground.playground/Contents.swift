import UIKit
import Foundation
import RecurrenceRule

let calendar: Calendar = Calendar(identifier: .iso8601)
let timeZone: TimeZone = .current
print(timeZone)
let dateFormatter = ISO8601DateFormatter()
dateFormatter.timeZone = timeZone
let rule: Legacy.RecurrenceRule = Legacy.RecurrenceRule(frequency: .weekly, interval: 2, firstDayOfTheWeek: 1, daysOfTheWeek: [.init(dayOfTheWeek: .friday, weekNumber: 1)])




let date0: Date = DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 5, day: 4).date!
let date1: Date = DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 1, day: 1).date!

let startDate = calendar.dateComponents([.calendar, .timeZone, .year, .month, .yearForWeekOfYear, .weekOfYear, .weekOfMonth], from: date0).date!

print(dateFormatter.string(from: startDate))
print(dateFormatter.string(from: calendar.date(byAdding: .weekday, value: 1, to: startDate)!))

if rule.frequency == .weekly {

    let diff = calendar.dateComponents([.weekOfMonth], from: date0, to: date1)
    print(diff)
}

let isDate = calendar.isDate(date0, equalTo: date1, toGranularity: .weekday)

print(isDate)

if #available(iOS 18.0, *) {
    let rule0 = Legacy.RecurrenceRule(frequency: .weekly, interval: 1)
    let rule1 = Calendar.RecurrenceRule(calendar: calendar, frequency: .weekly)
    
    let data0 = try! JSONEncoder().encode(rule0)
    let data1 = try! JSONEncoder().encode(rule1)
    
    let json0 = try! JSONSerialization.jsonObject(with: data0)
    let json1 = try! JSONSerialization.jsonObject(with: data1)
    
    print(json0)
    print(json1)
}

