import XCTest
@testable import RecurrenceRule

@available(iOS 18, macOS 15, *)
final class RecurrenceRuleConverterTests: XCTestCase {
    
    let calendar: Calendar = Calendar(identifier: .iso8601)
    let timeZone: TimeZone = TimeZone(identifier: "UTC")!
    
    var startDate: Date { calendar.startOfDay(for: DateComponents(calendar: calendar, timeZone: timeZone, year: 2022, month: 1, day: 1).date!) }
    
    var endDate: Date { calendar.startOfDay(for: DateComponents(calendar: calendar, timeZone: timeZone, year: 2023, month: 5, day: 5).date!) }
    
    func testDailyRecurrenceConversion() {
        let legacyRule = Legacy.RecurrenceRule.gregorian(
            frequency: .daily,
            interval: 2,
            daysOfTheWeek: [
                Legacy.RecurrenceRule.DayOfWeek(dayOfTheWeek: .monday),
                Legacy.RecurrenceRule.DayOfWeek(dayOfTheWeek: .wednesday)
            ]
        )
        
        let calendarRule = legacyRule.toCalendarRecurrenceRule()
        
        XCTAssertEqual(calendarRule.frequency, .daily)
        XCTAssertEqual(calendarRule.interval, 2)
        XCTAssertEqual(calendarRule.weekdays.count, 2)
        XCTAssertEqual(calendarRule.calendar.identifier, .gregorian)
    }
    
    func testWeeklyRecurrenceWithEndDateConversion() {
        let endDate = Date()
        let legacyRule = Legacy.RecurrenceRule.iso8601(
            frequency: .weekly,
            recurrenceEnd: .endDate(endDate),
            interval: 1,
            daysOfTheWeek: [
                Legacy.RecurrenceRule.DayOfWeek(dayOfTheWeek: .monday, weekNumber: 1),
                Legacy.RecurrenceRule.DayOfWeek(dayOfTheWeek: .friday, weekNumber: -1)
            ]
        )
        
        let calendarRule = legacyRule.toCalendarRecurrenceRule()
        
        XCTAssertEqual(calendarRule.frequency, .weekly)
        XCTAssertEqual(calendarRule.interval, 1)
        XCTAssertEqual(calendarRule.weekdays.count, 2)
        XCTAssertEqual(calendarRule.calendar.identifier, .iso8601)
        XCTAssertNotNil(calendarRule.end.date)
        XCTAssertEqual(calendarRule.end.date!.timeIntervalSinceReferenceDate,
                       endDate.timeIntervalSinceReferenceDate,
                       accuracy: 1.0)
    }
    
    func testMonthlyRecurrenceWithOccurrencesConversion() {
        // Arrange
        let legacyRule = Legacy.RecurrenceRule.gregorian(
            frequency: .monthly,
            recurrenceEnd: .occurrenceCount(5),
            interval: 3,
            daysOfTheMonth: [1, 15, -1]
        )
        
        // Act
        let calendarRule = legacyRule.toCalendarRecurrenceRule()
        print(calendarRule)
        
        // Assert
        XCTAssertEqual(calendarRule.frequency, .monthly)
        XCTAssertEqual(calendarRule.interval, 3)
        XCTAssertEqual(calendarRule.daysOfTheMonth, [1, 15, -1])
        XCTAssertEqual(calendarRule.end.occurrences, 5)        
    }
    
    func testYearlyRecurrenceWithComplexRuleConversion() {
        let legacyRule = Legacy.RecurrenceRule.gregorian(
            frequency: .yearly,
            interval: 1,
            daysOfTheWeek: [
                Legacy.RecurrenceRule.DayOfWeek(dayOfTheWeek: .monday, weekNumber: 1)
            ],
            monthsOfTheYear: [.january, .june]
        )
        
        let calendarRule = legacyRule.toCalendarRecurrenceRule()
        
        XCTAssertEqual(calendarRule.frequency, .yearly)
        XCTAssertEqual(calendarRule.interval, 1)
        XCTAssertEqual(calendarRule.months.count, 2)
        XCTAssertEqual(calendarRule.months.map { $0.index }, [1, 6])
        XCTAssertEqual(calendarRule.weekdays.count, 1)
    }
    
    // MARK: - Calendar -> Legacy Tests
    
    func testCalendarToDailyLegacyConversion() {
        let calendar = Calendar(identifier: .gregorian)
        let calendarRule = Calendar.RecurrenceRule.daily(
            calendar: calendar,
            interval: 2,
            end: .afterOccurrences(10),
            daysOfTheMonth: [1, 15],
            weekdays: [.every(.monday), .nth(1, .friday)]
        )
        
        let legacyRule = calendarRule.toLegacyRecurrenceRule()
        
        XCTAssertEqual(legacyRule.frequency, .daily)
        XCTAssertEqual(legacyRule.interval, 2)
        XCTAssertEqual(legacyRule.daysOfTheMonth, [1, 15])
        XCTAssertEqual(legacyRule.daysOfTheWeek?.count, 2)
        if case .occurrenceCount(let count) = legacyRule.recurrenceEnd {
            XCTAssertEqual(count, 10)
        } else {
            XCTFail("Expected occurrence count end")
        }
    }
    
    func testCalendarToWeeklyLegacyConversion() {
        let calendar = Calendar(identifier: .iso8601)
        let endDate = Date()
        let calendarRule = Calendar.RecurrenceRule.weekly(
            calendar: calendar,
            interval: 1,
            end: .afterDate(endDate),
            months: [Calendar.RecurrenceRule.Month(1)],
            weekdays: [.every(.monday)]
        )
        
        let legacyRule = calendarRule.toLegacyRecurrenceRule()
        
        XCTAssertEqual(legacyRule.frequency, .weekly)
        XCTAssertEqual(legacyRule.interval, 1)
        XCTAssertEqual(legacyRule.firstDayOfTheWeek, Legacy.RecurrenceRule.Weekday.monday.rawValue)
        XCTAssertEqual(legacyRule.monthsOfTheYear, [.january])
        if case .endDate(let date) = legacyRule.recurrenceEnd {
            XCTAssertEqual(date.timeIntervalSinceReferenceDate,
                           endDate.timeIntervalSinceReferenceDate,
                           accuracy: 1.0)
        } else {
            XCTFail("Expected end date")
        }
    }
    
    func testRoundTripConversion() {
        let originalLegacy = Legacy.RecurrenceRule.gregorian(
            frequency: .monthly,
            recurrenceEnd: .occurrenceCount(5),
            interval: 2,
            daysOfTheWeek: [
                Legacy.RecurrenceRule.DayOfWeek(dayOfTheWeek: .monday, weekNumber: 1),
                Legacy.RecurrenceRule.DayOfWeek(dayOfTheWeek: .friday)
            ],
            monthsOfTheYear: [.march, .september]
        )
        
        let calendar = originalLegacy.toCalendarRecurrenceRule()
        let convertedBack = calendar.toLegacyRecurrenceRule()
        
        // 主要な属性の比較
        XCTAssertEqual(originalLegacy.frequency, convertedBack.frequency)
        XCTAssertEqual(originalLegacy.interval, convertedBack.interval)
        XCTAssertEqual(originalLegacy.monthsOfTheYear, convertedBack.monthsOfTheYear)
        XCTAssertEqual(originalLegacy.daysOfTheWeek?.count, convertedBack.daysOfTheWeek?.count)
        
        // 終了条件の比較
        if case .occurrenceCount(let originalCount) = originalLegacy.recurrenceEnd,
           case .occurrenceCount(let convertedCount) = convertedBack.recurrenceEnd {
            XCTAssertEqual(originalCount, convertedCount)
        } else {
            XCTFail("Expected occurrence count end")
        }
    }
    
    // MARK: - Complex Date Pattern Tests
    
    func testLastDayOfMonthRecurrence() {
        let legacyRule = Legacy.RecurrenceRule.gregorian(
            frequency: .monthly,
            interval: 1,
            daysOfTheMonth: [-1] // 月末日
        )
        
        let calendarRule = legacyRule.toCalendarRecurrenceRule()
        let convertedBack = calendarRule.toLegacyRecurrenceRule()
        
        XCTAssertEqual(calendarRule.daysOfTheMonth, [-1])
        XCTAssertEqual(convertedBack.daysOfTheMonth, [-1])
        
        // 実際の日付で検証
        let recurrences = calendarRule.recurrences(of: startDate, in: startDate..<endDate)
        let dates = Array(recurrences)
        
        // 各日付が月末日であることを確認
        for date in dates {
            let components = calendar.dateComponents([.day, .month, .year], from: date)
            let range = calendar.range(of: .day, in: .month, for: date)!
            XCTAssertEqual(components.day, range.count)
        }
    }
    
    func testWeekdayInMonthRecurrence() {
        // 第3月曜日
        let legacyRule = Legacy.RecurrenceRule.gregorian(
            frequency: .monthly,
            interval: 1,
            daysOfTheWeek: [
                Legacy.RecurrenceRule.DayOfWeek(dayOfTheWeek: .monday, weekNumber: 3)
            ]
        )
        
        let calendarRule = legacyRule.toCalendarRecurrenceRule()
        let convertedBack = calendarRule.toLegacyRecurrenceRule()
        
        XCTAssertEqual(calendarRule.weekdays.count, 1)
        if case .nth(let weekNumber, let weekday) = calendarRule.weekdays.first {
            XCTAssertEqual(weekNumber, 3)
            XCTAssertEqual(weekday, .monday)
        } else {
            XCTFail("Expected nth weekday")
        }
        
        XCTAssertEqual(convertedBack.daysOfTheWeek?.first?.weekNumber, 3)
        XCTAssertEqual(convertedBack.daysOfTheWeek?.first?.dayOfTheWeek, .monday)
    }
    
    // MARK: - Edge Cases Tests
    
    func testEmptyRuleConversion() {
        let legacyRule = Legacy.RecurrenceRule.gregorian(
            frequency: .daily,
            interval: 1
        )
        
        let calendarRule = legacyRule.toCalendarRecurrenceRule()
        let convertedBack = calendarRule.toLegacyRecurrenceRule()
        
        XCTAssertTrue(calendarRule.weekdays.isEmpty)
        XCTAssertTrue(calendarRule.daysOfTheMonth.isEmpty)
        XCTAssertTrue(calendarRule.months.isEmpty)
        XCTAssertNil(convertedBack.daysOfTheWeek)
        XCTAssertNil(convertedBack.daysOfTheMonth)
        XCTAssertNil(convertedBack.monthsOfTheYear)
    }
    
    func testMaximumValuesConversion() {
        let legacyRule = Legacy.RecurrenceRule.gregorian(
            frequency: .yearly,
            recurrenceEnd: .occurrenceCount(Int.max),
            interval: Int.max,
            daysOfTheWeek: [
                Legacy.RecurrenceRule.DayOfWeek(dayOfTheWeek: .monday, weekNumber: Int.max),
                Legacy.RecurrenceRule.DayOfWeek(dayOfTheWeek: .friday, weekNumber: Int.min)
            ],
            daysOfTheMonth: [Int.max, Int.min],
            monthsOfTheYear: [.december]
        )
        
        let calendarRule = legacyRule.toCalendarRecurrenceRule()
        let convertedBack = calendarRule.toLegacyRecurrenceRule()
        
        XCTAssertEqual(calendarRule.interval, Int.max)
        XCTAssertEqual(convertedBack.interval, Int.max)
    }
    
    // MARK: - Multiple Conditions Tests
    
    func testComplexMultipleConditionsConversion() {
        let legacyRule = Legacy.RecurrenceRule.gregorian(
            frequency: .yearly,
            recurrenceEnd: .occurrenceCount(10),
            interval: 2,
            daysOfTheWeek: [
                Legacy.RecurrenceRule.DayOfWeek(dayOfTheWeek: .monday, weekNumber: 1),
                Legacy.RecurrenceRule.DayOfWeek(dayOfTheWeek: .friday, weekNumber: -1)
            ],
            daysOfTheMonth: [1, 15, -1],
            daysOfTheYear: [1, 100, 200, -1],
            weeksOfTheYear: [1, 26, 52],
            monthsOfTheYear: [.march, .june, .september, .december]
        )
        
        let calendarRule = legacyRule.toCalendarRecurrenceRule()
        let convertedBack = calendarRule.toLegacyRecurrenceRule()
        
        // 基本属性の検証
        XCTAssertEqual(calendarRule.frequency, .yearly)
        XCTAssertEqual(calendarRule.interval, 2)
        
        // 詳細な条件の検証
        XCTAssertEqual(calendarRule.daysOfTheMonth, [1, 15, -1])
        XCTAssertEqual(calendarRule.daysOfTheYear, [1, 100, 200, -1])
        XCTAssertEqual(calendarRule.weeks, [1, 26, 52])
        XCTAssertEqual(calendarRule.months.map { $0.index }, [3, 6, 9, 12])
        
        // 往復変換の検証
        XCTAssertEqual(convertedBack.frequency, .yearly)
        XCTAssertEqual(convertedBack.interval, 2)
        XCTAssertEqual(convertedBack.daysOfTheMonth, [1, 15, -1])
        XCTAssertEqual(convertedBack.daysOfTheYear, [1, 100, 200, -1])
        XCTAssertEqual(convertedBack.weeksOfTheYear, [1, 26, 52])
        XCTAssertEqual(convertedBack.monthsOfTheYear, [.march, .june, .september, .december])
    }
    
    func testEndDateAtMidnightConversion() {
        let endDate = calendar.startOfDay(for: self.endDate)
        let legacyRule = Legacy.RecurrenceRule.gregorian(
            frequency: .daily,
            recurrenceEnd: .endDate(endDate),
            interval: 1
        )
        
        let calendarRule = legacyRule.toCalendarRecurrenceRule()
        let convertedBack = calendarRule.toLegacyRecurrenceRule()
        
        if case .endDate(let convertedDate) = convertedBack.recurrenceEnd {
            XCTAssertEqual(
                calendar.startOfDay(for: convertedDate),
                calendar.startOfDay(for: endDate)
            )
        } else {
            XCTFail("Expected end date")
        }
    }
}
