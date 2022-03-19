import XCTest
@testable import RecurrenceRule

final class MonthlyTests: XCTestCase {

    let calendar: Calendar = Calendar(identifier: .iso8601)
    let timeZone: TimeZone = TimeZone(identifier: "UTC")!

    var startDate: Date { calendar.startOfDay(for: DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 1, day: 1).date!) }

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

    func matching(_ date: Date, rule: RecurrenceRule) -> Bool {
        return calendar.contains(date, in: rule, occurenceDate: startDate)
    }

    func testInterval1() throws {
        let rule: RecurrenceRule = RecurrenceRule.iso8601(frequency: .monthly, interval: 1)
        XCTAssertEqual(matching(targetDate(day: 1, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 2, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 3, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 4, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 5, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 6, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 7, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 8, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 9, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 10, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 11, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 12, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 13, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 14, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 15, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 16, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 17, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 18, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 19, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 20, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 21, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 22, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 23, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 24, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 25, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 26, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 27, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 28, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 29, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 30, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 31, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 32, to: startDate), rule: rule), false)

        XCTAssertEqual(matching(targetDate(month: 1, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 3, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 4, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 5, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 6, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 7, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 8, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 9, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 10, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 11, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 12, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 13, to: startDate), rule: rule), true)
    }

    func testInterval2() throws {
        let rule: RecurrenceRule = RecurrenceRule.iso8601(frequency: .monthly, interval: 2)
        XCTAssertEqual(matching(targetDate(day: 1, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 2, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 3, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 4, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 5, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 6, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 7, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 8, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 9, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 10, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 11, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 12, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 13, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 14, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 15, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 16, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 17, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 18, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 19, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 20, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 21, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 22, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 23, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 24, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 25, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 26, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 27, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 28, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 29, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 30, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 31, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 32, to: startDate), rule: rule), false)

        XCTAssertEqual(matching(targetDate(month: 1, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 3, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 4, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 5, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 6, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 7, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 8, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 9, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 10, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 11, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 12, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 13, to: startDate), rule: rule), false)

    }

    func testInterval1Monday() throws {
        let rule: RecurrenceRule = RecurrenceRule.iso8601(frequency: .monthly, interval: 1, daysOfTheWeek: [.init(dayOfTheWeek: .monday)])

        XCTAssertEqual(matching(targetDate(month: 1, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 2, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 3, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 4, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 5, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 6, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 7, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 8, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 9, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 10, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 11, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 12, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 13, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
    }

    func testInterval1MondayFriday() throws {
        let rule: RecurrenceRule = RecurrenceRule.iso8601(frequency: .monthly, interval: 1, daysOfTheWeek: [.init(dayOfTheWeek: .monday), .init(dayOfTheWeek: .friday)])

        XCTAssertEqual(matching(targetDate(month: 1, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 2, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 3, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 4, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 5, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 6, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 7, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 8, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 9, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 10, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 11, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 12, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 13, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)

        XCTAssertEqual(matching(targetDate(month: 1, weekday: RecurrenceRule.Weekday.friday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 2, weekday: RecurrenceRule.Weekday.friday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 3, weekday: RecurrenceRule.Weekday.friday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 4, weekday: RecurrenceRule.Weekday.friday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 5, weekday: RecurrenceRule.Weekday.friday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 6, weekday: RecurrenceRule.Weekday.friday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 7, weekday: RecurrenceRule.Weekday.friday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 8, weekday: RecurrenceRule.Weekday.friday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 9, weekday: RecurrenceRule.Weekday.friday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 10, weekday: RecurrenceRule.Weekday.friday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 11, weekday: RecurrenceRule.Weekday.friday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 12, weekday: RecurrenceRule.Weekday.friday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 13, weekday: RecurrenceRule.Weekday.friday.rawValue, to: startDate), rule: rule), true)
    }

    func testInterval1MondayWeekNumber() throws {
        let rule: RecurrenceRule = RecurrenceRule.iso8601(frequency: .monthly, interval: 1, daysOfTheWeek: [.init(dayOfTheWeek: .monday, weekNumber: 2)])

        XCTAssertEqual(matching(targetDate(month: 1, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), false) // monday is january
        XCTAssertEqual(matching(targetDate(month: 1, week: 1, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 1, week: 2, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 1, week: 3, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 1, week: 4, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 2, week: 1, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 2, week: 2, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 2, week: 3, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 2, week: 4, weekday: RecurrenceRule.Weekday.monday.rawValue, to: startDate), rule: rule), false)
    }

    func testInterval1Days() throws {
        let rule: RecurrenceRule = RecurrenceRule.iso8601(frequency: .monthly, interval: 1, daysOfTheMonth: [1, 3, 5, 7, 9])

        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 1).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 2).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 3).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 4).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 5).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 6).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 7).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 8).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 9).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 10).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 11).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 12).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 13).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 14).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 15).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 16).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 17).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 18).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 19).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 2, day: 20).date!, rule: rule), false)

        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 1).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 2).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 3).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 4).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 5).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 6).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 7).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 8).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 9).date!, rule: rule), true)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 10).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 11).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 12).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 13).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 14).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 15).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 16).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 17).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 18).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 19).date!, rule: rule), false)
        XCTAssertEqual(matching(DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 3, day: 20).date!, rule: rule), false)
    }
}
