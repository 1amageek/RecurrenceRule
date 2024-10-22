//
//  RecurrenceRule+.swift
//  RecurrenceRule
//
//  Created by Norikazu Muramoto on 2024/10/22.
//

import Foundation

extension Legacy.RecurrenceRule {
 
    @available(iOS 18, macOS 15, *)
    public func toCalendarRecurrenceRule() -> Calendar.RecurrenceRule {
        let calendar = Calendar(identifier: self.firstDayOfTheWeek == Legacy.RecurrenceRule.Weekday.monday.rawValue ? .iso8601 : .gregorian)
        let frequency: Calendar.RecurrenceRule.Frequency
        switch self.frequency {
        case .daily:
            frequency = .daily
        case .weekly:
            frequency = .weekly
        case .monthly:
            frequency = .monthly
        case .yearly:
            frequency = .yearly
        }
        
        let end: Calendar.RecurrenceRule.End
        if let recurrenceEnd = self.recurrenceEnd {
            switch recurrenceEnd {
            case .endDate(let date):
                end = .afterDate(date)
            case .occurrenceCount(let count):
                end = .afterOccurrences(count)
            }
        } else {
            end = .never
        }
        
        let weekdays: [Calendar.RecurrenceRule.Weekday] = self.daysOfTheWeek?.map { dayOfWeek in
            let weekday: Locale.Weekday
            switch dayOfWeek.dayOfTheWeek {
            case .sunday:
                weekday = .sunday
            case .monday:
                weekday = .monday
            case .tuesday:
                weekday = .tuesday
            case .wednesday:
                weekday = .wednesday
            case .thursday:
                weekday = .thursday
            case .friday:
                weekday = .friday
            case .saturday:
                weekday = .saturday
            }
            
            if dayOfWeek.weekNumber == 0 {
                return .every(weekday)
            } else {
                return .nth(dayOfWeek.weekNumber, weekday)
            }
        } ?? []
        
        // 月の変換
        let months: [Calendar.RecurrenceRule.Month] = self.monthsOfTheYear?.map { month in
            Calendar.RecurrenceRule.Month(month.rawValue)
        } ?? []
        
        // RecurrenceRuleの作成
        switch frequency {
        case .daily:
            return .daily(
                calendar: calendar,
                interval: self.interval,
                end: end,
                daysOfTheMonth: self.daysOfTheMonth ?? [],
                weekdays: weekdays
            )
            
        case .weekly:
            return .weekly(
                calendar: calendar,
                interval: self.interval,
                end: end,
                months: months,
                weekdays: weekdays
            )
            
        case .monthly:
            return .monthly(
                calendar: calendar,
                interval: self.interval,
                end: end,
                months: months,
                daysOfTheMonth: self.daysOfTheMonth ?? [],
                weekdays: weekdays
            )
            
        case .yearly:
            return .yearly(
                calendar: calendar,
                interval: self.interval,
                end: end,
                months: months,
                daysOfTheYear: self.daysOfTheYear ?? [],
                daysOfTheMonth: self.daysOfTheMonth ?? [],
                weeks: self.weeksOfTheYear ?? [],
                weekdays: weekdays
            )
            
        default:
            return .daily(
                calendar: calendar,
                interval: self.interval,
                end: end
            )
        }
    }
}

@available(iOS 18, macOS 15, *)
extension Calendar.RecurrenceRule {
    
    public func toLegacyRecurrenceRule() -> Legacy.RecurrenceRule {

        let frequency: Legacy.RecurrenceRule.Frequency
        switch self.frequency {
        case .daily:
            frequency = .daily
        case .weekly:
            frequency = .weekly
        case .monthly:
            frequency = .monthly
        case .yearly:
            frequency = .yearly
        case .minutely:
            fatalError()
        case .hourly:
            fatalError()
        @unknown default:
            fatalError()
        }
        
        // 終了条件の変換
        let recurrenceEnd: Legacy.RecurrenceRule.End?
        if let occurrences = self.end.occurrences {
            recurrenceEnd = .occurrenceCount(occurrences)
        } else if let date = self.end.date {
            recurrenceEnd = .endDate(date)
        } else {
            recurrenceEnd = nil
        }
        
        // 曜日の変換
        let daysOfTheWeek: [Legacy.RecurrenceRule.DayOfWeek] = self.weekdays.compactMap { weekday in
            let legacyWeekday: Legacy.RecurrenceRule.Weekday
            switch weekday {
            case .every(let day), .nth(_, let day):
                switch day {
                case .sunday:
                    legacyWeekday = .sunday
                case .monday:
                    legacyWeekday = .monday
                case .tuesday:
                    legacyWeekday = .tuesday
                case .wednesday:
                    legacyWeekday = .wednesday
                case .thursday:
                    legacyWeekday = .thursday
                case .friday:
                    legacyWeekday = .friday
                case .saturday:
                    legacyWeekday = .saturday
                @unknown default:
                    fatalError()
                }
            @unknown default:
                fatalError()
            }
            
            let weekNumber: Int
            switch weekday {
            case .every(_):
                weekNumber = 0
            case .nth(let n, _):
                weekNumber = n
            @unknown default:
                fatalError()
            }
            
            return Legacy.RecurrenceRule.DayOfWeek(dayOfTheWeek: legacyWeekday, weekNumber: weekNumber)
        }
        
        // 月の変換
        let monthsOfTheYear: [Legacy.RecurrenceRule.Month] = self.months.compactMap { month in
            Legacy.RecurrenceRule.Month(rawValue: month.index)
        }
        
        // カレンダー形式の判定
        let firstDayOfTheWeek = self.calendar.identifier == .iso8601 ?
        Legacy.RecurrenceRule.Weekday.monday.rawValue :
        Legacy.RecurrenceRule.Weekday.sunday.rawValue
        
        return Legacy.RecurrenceRule(
            frequency: frequency,
            recurrenceEnd: recurrenceEnd,
            interval: self.interval,
            offset: 0, // Calendarには対応する値がないため、デフォルト値を使用
            firstDayOfTheWeek: firstDayOfTheWeek,
            daysOfTheWeek: daysOfTheWeek.isEmpty ? nil : daysOfTheWeek,
            daysOfTheMonth: self.daysOfTheMonth.isEmpty ? nil : self.daysOfTheMonth,
            daysOfTheYear: self.daysOfTheYear.isEmpty ? nil : self.daysOfTheYear,
            weeksOfTheYear: self.weeks.isEmpty ? nil : self.weeks,
            monthsOfTheYear: monthsOfTheYear.isEmpty ? nil : monthsOfTheYear
        )
    }
}

@available(iOS 18, macOS 15, *)
extension Calendar.RecurrenceRule.End {
    
    var occurrences: Int? {
        guard let data = try? JSONEncoder().encode(self),
              let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
              let occurrences = jsonObject["count"] as? Int else {
            return nil
        }
        return occurrences
    }
    
    var date: Date? {
        guard let data = try? JSONEncoder().encode(self),
              let jsonObject: [String: Any] = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let timestamp = jsonObject["until"] as? TimeInterval else {
            return nil
        }
        let date = Date(timeIntervalSinceReferenceDate: timestamp)
        return date
    }
}
