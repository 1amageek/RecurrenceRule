import XCTest
@testable import RecurrenceRule

final class WeeklyTests: XCTestCase {

    let calendar: Calendar = Calendar(identifier: .iso8601)
    let timeZone: TimeZone = TimeZone(identifier: "UTC")!

    var startDate: Date { calendar.startOfDay(for: DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 1, day: 1).date!) }

    func targetDate(year: Int? = nil, month: Int? = nil, week: Int? = nil, day: Int? = nil, to: Date) -> Date {
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
        if let day = day {
            targetDate = calendar.date(byAdding: .day, value: day, to: targetDate)!
        }
        return targetDate
    }

    func matching(_ date: Date, rule: RecurrenceRule) -> Bool {
        return calendar.contains(date, in: rule, occurenceDate: startDate)
    }

    func testInterval1() throws {
        let rule: RecurrenceRule = RecurrenceRule.iso8601(frequency: .weekly, interval: 1)
        XCTAssertEqual(matching(targetDate(day: 1, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 2, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 3, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 4, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 5, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 6, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 7, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 8, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 9, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 10, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 11, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 12, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 13, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 14, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 15, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 16, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 17, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 18, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 19, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 20, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 21, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 22, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 23, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 24, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 25, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 26, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 27, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 28, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 29, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 30, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 31, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 32, to: startDate), rule: rule), false)

        XCTAssertEqual(matching(targetDate(week: 1, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 3, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 4, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 5, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 6, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 7, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 8, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 9, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 10, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 11, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 12, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 13, to: startDate), rule: rule), true)
    }

    func testInterval2() throws {
        let rule: RecurrenceRule = RecurrenceRule.iso8601(frequency: .weekly, interval: 2)
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
        XCTAssertEqual(matching(targetDate(day: 14, to: startDate), rule: rule), true)
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
        XCTAssertEqual(matching(targetDate(day: 28, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 29, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 30, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 31, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 32, to: startDate), rule: rule), false)

    }

    func testInterval1Monday() throws {
        let rule: RecurrenceRule = RecurrenceRule.iso8601(frequency: .weekly, interval: 1, daysOfTheWeek: [.init(dayOfTheWeek: .monday)])
        XCTAssertEqual(matching(targetDate(day: 1, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 3, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 4, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 5, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 6, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 7, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 8, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 9, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 10, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 11, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 12, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 13, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 14, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 15, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 16, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 17, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 18, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 19, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 20, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 21, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 22, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 23, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 24, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 25, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 26, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 27, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 28, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 29, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 30, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 31, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 32, to: startDate), rule: rule), false)

        XCTAssertEqual(matching(targetDate(week: 1, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 2, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 3, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 4, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 5, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 6, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 7, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 8, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 9, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 10, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 11, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 12, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 13, day: 2, to: startDate), rule: rule), true)
    }

    func testInterval1MondayFriday() throws {
        let rule: RecurrenceRule = RecurrenceRule.iso8601(frequency: .weekly, interval: 1, daysOfTheWeek: [.init(dayOfTheWeek: .monday), .init(dayOfTheWeek: .friday)])
        XCTAssertEqual(matching(targetDate(day: 1, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 3, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 4, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 5, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 6, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 7, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 8, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 9, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 10, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 11, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 12, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 13, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 14, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 15, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 16, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 17, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 18, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 19, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 20, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 21, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 22, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 23, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 24, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 25, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 26, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 27, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 28, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 29, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 30, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(day: 31, to: startDate), rule: rule), false)
        XCTAssertEqual(matching(targetDate(day: 32, to: startDate), rule: rule), false)

        XCTAssertEqual(matching(targetDate(week: 1, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 2, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 3, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 4, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 5, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 6, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 7, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 8, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 9, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 10, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 11, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 12, day: 2, to: startDate), rule: rule), true)
        XCTAssertEqual(matching(targetDate(week: 13, day: 2, to: startDate), rule: rule), true)
    }
}