import XCTest
@testable import RecurrenceRule

final class YearlyTests: XCTestCase {

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

    func matching(_ date: Date, rule: Legacy.RecurrenceRule) -> Bool {
        return calendar.contains(date, in: rule, occurenceDate: startDate)
    }

    func testInterval1() throws {
        let rule: Legacy.RecurrenceRule = Legacy.RecurrenceRule.iso8601(frequency: .yearly, interval: 1, monthsOfTheYear: [.january])
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

        XCTAssertEqual(matching(targetDate(year: 1, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 3, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 4, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 5, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 6, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 7, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 8, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 9, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 10, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 11, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 12, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 13, to: startDate), rule: rule), true)
    }

    func testInterval2() throws {
        let rule: Legacy.RecurrenceRule = Legacy.RecurrenceRule.iso8601(frequency: .yearly, interval: 2, monthsOfTheYear: [.january])
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

        XCTAssertEqual(matching(targetDate(year: 1, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 3, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 4, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 5, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 6, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 7, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 8, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 9, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 10, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 11, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 12, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 13, to: startDate), rule: rule), false)

    }

    func testInterval1MonthsOfYear() throws {
        let rule: Legacy.RecurrenceRule = Legacy.RecurrenceRule.iso8601(frequency: .yearly, interval: 1, monthsOfTheYear: [.january, .march, .may, .july, .september])

        XCTAssertEqual(matching(targetDate(month: 1, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 3, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 4, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 5, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 6, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 7, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 8, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 9, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 10, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 11, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 12, to: startDate), rule: rule), true)

        XCTAssertEqual(matching(targetDate(year: 1, month: 1, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 1, month: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 1, month: 3, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 1, month: 4, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 1, month: 5, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 1, month: 6, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 1, month: 7, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 1, month: 8, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 1, month: 9, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 1, month: 10, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 1, month: 11, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 1, month: 12, to: startDate), rule: rule), true)
    }

    func testInterval1MonthsOfYearsAndDaysOfMonths() throws {
        let rule: Legacy.RecurrenceRule = Legacy.RecurrenceRule.iso8601(frequency: .yearly,
                                                          interval: 1,
                                                          daysOfTheWeek: [.init(dayOfTheWeek: .monday, weekNumber: 2)],
                                                          monthsOfTheYear: [.january, .march, .may, .july, .september])

        XCTAssertEqual(matching(targetDate(month: 1, week: 2, weekday: 2, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 2, week: 2, weekday: 2, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 3, week: 2, weekday: 2, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 4, week: 2, weekday: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 5, week: 2, weekday: 2, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 6, week: 2, weekday: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(month: 7, week: 2, weekday: 2, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 8, week: 2, weekday: 2, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 9, week: 2, weekday: 2, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 10, week: 2, weekday: 2, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 11, week: 2, weekday: 2, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(month: 12, week: 2, weekday: 2, to: startDate), rule: rule), true)
    }

    func testInterval2Offset1() throws {
        let rule: Legacy.RecurrenceRule = Legacy.RecurrenceRule.iso8601(frequency: .yearly, interval: 2, offset: 1, monthsOfTheYear: [.january])
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

        XCTAssertEqual(matching(targetDate(year: 1, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 2, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 3, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 4, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 5, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 6, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 7, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 8, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 9, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 10, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 11, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(year: 12, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(year: 13, to: startDate), rule: rule), true)

    }
}
