import UIKit
import RecurrenceRule

let calendar: Calendar = Calendar(identifier: .iso8601)
let timeZone: TimeZone = .current
print(timeZone)
let dateFormatter = ISO8601DateFormatter()
dateFormatter.timeZone = timeZone
let rule: RecurrenceRule = RecurrenceRule(frequency: .weekly, interval: 2, firstDayOfTheWeek: 1, daysOfTheWeek: [.init(dayOfTheWeek: .friday, weekNumber: 1)])




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
//
//let result = calendar.compare(date0, to: date1, toGranularity: .weekday)
//
//switch result {
//    case .orderedAscending: print("Ascending")
//    case .orderedDescending: print("Descending")
//    case .orderedSame: print("Same")
//}
//
//calendar.date(date0, matchesComponents: DateComponents(calendar: .current, timeZone: .current, year: 2022, month: 3, day: 24))

//
//calendar.enumerateDates(startingAfter: Date(), matching: DateComponents(calendar: .current, timeZone: .current, year: 2022, month: 3, day: 24), matchingPolicy: .nextTime) { result, exactMatch, stop in
//
//    print(result, exactMatch, stop)
//
//}


//let nextDate = calendar.nextDate(after: date0,
//                                 matching: DateComponents(calendar: calendar, timeZone: timeZone, weekday: 3, weekOfMonth: 3),
//                                 matchingPolicy: .strict,
//                                 repeatedTimePolicy: .first,
//                                 direction: .forward)!
//
//print(dateFormatter.string(from: nextDate))

