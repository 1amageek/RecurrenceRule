import XCTest
@testable import RecurrenceRule

final class EndTests: XCTestCase {

    let calendar: Calendar = Calendar(identifier: .iso8601)
    let timeZone: TimeZone = TimeZone(identifier: "UTC")!

    var startDate: Date { calendar.startOfDay(for: DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 1, day: 1).date!) }

    var endDate: Date { calendar.startOfDay(for: DateComponents(calendar: calendar, timeZone: timeZone, year: 2023, month: 5, day: 5).date!) }

    func targetDate(year: Int? = nil, month: Int? = nil, week: Int? = nil, weekday: Int? = nil, day: Int? = nil, to: Date) -> Date {
        var targetDate: Date = to
        if let year = year {
            targetDate = calendar.date(byAdding: .year, value: year, to: targetDate)!
        }
        if let month = month {
            targetDate = calendar.date(byAdding: .month, value: month, to: targetDate)!
        }
        if let week = week {
            targetDate = calendar.date(byAdding: .day, value: week * 7, to: targetDate)!
        }
        if let weekday = weekday {
            targetDate = calendar.dateComponents([.calendar, .timeZone, .year, .month, .yearForWeekOfYear, .weekOfYear, .weekOfMonth], from: targetDate).date!
            // iso8601の週初めは月曜日 weekdayの月曜日は2
            targetDate = calendar.date(byAdding: .weekday, value: weekday - 2, to: targetDate)!
        }
        if let day = day {
            targetDate = calendar.date(byAdding: .day, value: day, to: targetDate)!
        }
        return targetDate
    }

    func matching(_ date: Date, rule: Legacy.RecurrenceRule) -> Bool {
        return calendar.contains(date, in: rule, occurenceDate: startDate)
    }

    func testDaily() throws {
        let rule: Legacy.RecurrenceRule = Legacy.RecurrenceRule.iso8601(frequency: .daily, recurrenceEnd: .endDate(endDate), interval: 1)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2023, month: 5, day: 3).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2023, month: 5, day: 4).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2023, month: 5, day: 5).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2023, month: 5, day: 6).date!, rule: rule), false)
    }

    func testWeekly() throws {
        let rule: Legacy.RecurrenceRule = Legacy.RecurrenceRule.iso8601(frequency: .weekly, recurrenceEnd: .endDate(endDate), interval: 1)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2023, month: 4, day: 22).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2023, month: 4, day: 29).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2023, month: 5, day: 6).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2023, month: 5, day: 13).date!, rule: rule), false)
    }

    func testMonthly() throws {
        let rule: Legacy.RecurrenceRule = Legacy.RecurrenceRule.iso8601(frequency: .monthly, recurrenceEnd: .endDate(endDate), interval: 1, daysOfTheMonth: [5, 6])
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2023, month: 4, day: 5).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2023, month: 4, day: 6).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2024, month: 5, day: 5).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2024, month: 5, day: 6).date!, rule: rule), false)
    }

    func testYearly() throws {
        let rule: Legacy.RecurrenceRule = Legacy.RecurrenceRule.iso8601(frequency: .yearly, recurrenceEnd: .endDate(endDate), interval: 1, monthsOfTheYear: [.may])
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 5, day: 1).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2023, month: 5, day: 1).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2024, month: 5, day: 1).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2024, month: 5, day: 1).date!, rule: rule), false)
    }
}
