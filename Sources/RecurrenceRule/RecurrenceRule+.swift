//
//  RecurrenceRule+.swift
//  RecurrenceRule
//
//  Created by Norikazu Muramoto on 2024/10/22.
//

import Foundation

extension Legacy.RecurrenceRule {
 
    @available(iOS 18, macOS 14, *)
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
