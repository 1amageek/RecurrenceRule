//
//  RecurrenceRule.swift
//  RecurrenceRule
//
//  Created by nori on 2021/08/31.
//

import Foundation

public enum Legacy {
    
    public struct RecurrenceRule: Codable, Sendable {
        
        public enum Frequency: String, Codable, CaseIterable, Hashable, Sendable {
            case daily
            case weekly
            case monthly
            case yearly
        }
        
        public enum Weekday: Int, Codable, CaseIterable, Hashable, RawRepresentable, Sendable {
            case sunday = 1
            case monday = 2
            case tuesday = 3
            case wednesday = 4
            case thursday = 5
            case friday = 6
            case saturday = 7
            
            public var symbol: String {
                var calendar: Calendar = Calendar(identifier: .iso8601)
                calendar.locale = .autoupdatingCurrent
                let index: Int = rawValue - 1
                return calendar.weekdaySymbols[index]
            }
        }
        
        public enum Month: Int, Codable, CaseIterable, Hashable, RawRepresentable, Sendable {
            case january = 1
            case february = 2
            case march = 3
            case april = 4
            case may = 5
            case june = 6
            case july = 7
            case august = 8
            case september = 9
            case october = 10
            case november = 11
            case december = 12
            
            public var text: String {
                let calendar: Calendar = Calendar(identifier: .gregorian)
                let index: Int = rawValue - 1
                return calendar.monthSymbols[index]
            }
        }
        
        public struct DayOfWeek: Codable, Hashable, Sendable {
            public var dayOfTheWeek: Weekday
            public var weekNumber: Int
            
            public init(dayOfTheWeek: Weekday, weekNumber: Int = 0) {
                
                /// Values are from 1 to 7, with Sunday being 1.
                self.dayOfTheWeek = dayOfTheWeek
                
                /// Values range from –53 to 53.
                self.weekNumber = weekNumber
            }
            
            public static var sunday: Self { DayOfWeek(dayOfTheWeek: .sunday) }
            public static var monday: Self { DayOfWeek(dayOfTheWeek: .monday) }
            public static var tuesday: Self { DayOfWeek(dayOfTheWeek: .tuesday) }
            public static var wednesday: Self { DayOfWeek(dayOfTheWeek: .wednesday) }
            public static var thursday: Self { DayOfWeek(dayOfTheWeek: .thursday) }
            public static var friday: Self { DayOfWeek(dayOfTheWeek: .friday) }
            public static var saturday: Self { DayOfWeek(dayOfTheWeek: .saturday) }
        }
        
        public enum End: Codable, Hashable, Sendable {
            case endDate(Date)
            case occurrenceCount(Int)
        }
        
        public var frequency: Frequency
        
        public var recurrenceEnd: End?
        
        public var interval: Int
        
        public var offset: Int
        
        /// Values of 1 to 7 correspond to Sunday through Saturday. A value of 0 indicates that this property is not set for the recurrence rule.
        public var firstDayOfTheWeek: Int = 0       // 最初の曜日
        
        /// This property value is valid only for recurrence rules that were initialized with specific days of the week and a frequency type of Weekly, Monthly, or Yearly.
        public var daysOfTheWeek: [DayOfWeek]?      // 何曜日、第何週の何曜日
        
        /// Values can be from 1 to 31 and from -1 to -31.
        public var daysOfTheMonth: [Int]?           // 月の何日目
        
        /// Values can be from 1 to 366 and from -1 to -366.
        public var daysOfTheYear: [Int]?            // 年の何日目
        
        /// Values can be from 1 to 53 and from -1 to -53.
        public var weeksOfTheYear: [Int]?           // 年の何週目
        
        /// Values can be from 1 to 12.
        public var monthsOfTheYear: [Month]?          // 年の何ヶ月目
        
        public init(
            frequency: Frequency,
            recurrenceEnd: End? = nil,
            interval: Int,
            offset: Int = 0,
            firstDayOfTheWeek: Int = 0,
            daysOfTheWeek: [DayOfWeek]? = nil,
            daysOfTheMonth: [Int]? = nil,
            daysOfTheYear: [Int]? = nil,
            weeksOfTheYear: [Int]? = nil,
            monthsOfTheYear: [Month]? = nil
        ) {
            self.frequency = frequency
            self.recurrenceEnd = recurrenceEnd
            self.interval = interval
            self.offset = offset
            self.firstDayOfTheWeek = firstDayOfTheWeek
            self.daysOfTheWeek = daysOfTheWeek
            self.daysOfTheMonth = daysOfTheMonth
            self.daysOfTheYear = daysOfTheYear
            self.weeksOfTheYear = weeksOfTheYear
            self.monthsOfTheYear = monthsOfTheYear
        }
    }
}

extension Legacy.RecurrenceRule {
    
    public static func gregorian(
        frequency: Frequency,
        recurrenceEnd: End? = nil,
        interval: Int,
        offset: Int = 0,
        daysOfTheWeek: [DayOfWeek]? = nil,
        daysOfTheMonth: [Int]? = nil,
        daysOfTheYear: [Int]? = nil,
        weeksOfTheYear: [Int]? = nil,
        monthsOfTheYear: [Month]? = nil
    ) -> Self {
        Legacy.RecurrenceRule(frequency: frequency,
                       recurrenceEnd: recurrenceEnd,
                       interval: interval,
                       offset: offset,
                       firstDayOfTheWeek: Weekday.sunday.rawValue,
                       daysOfTheWeek: daysOfTheWeek,
                       daysOfTheMonth: daysOfTheMonth,
                       daysOfTheYear: daysOfTheYear,
                       weeksOfTheYear: weeksOfTheYear,
                       monthsOfTheYear: monthsOfTheYear)
    }
    
    public static func iso8601(
        frequency: Frequency,
        recurrenceEnd: End? = nil,
        interval: Int,
        offset: Int = 0,
        daysOfTheWeek: [DayOfWeek]? = nil,
        daysOfTheMonth: [Int]? = nil,
        daysOfTheYear: [Int]? = nil,
        weeksOfTheYear: [Int]? = nil,
        monthsOfTheYear: [Month]? = nil
    ) -> Self {
        Legacy.RecurrenceRule(frequency: frequency,
                       recurrenceEnd: recurrenceEnd,
                       interval: interval,
                       offset: offset,
                       firstDayOfTheWeek: Weekday.monday.rawValue,
                       daysOfTheWeek: daysOfTheWeek,
                       daysOfTheMonth: daysOfTheMonth,
                       daysOfTheYear: daysOfTheYear,
                       weeksOfTheYear: weeksOfTheYear,
                       monthsOfTheYear: monthsOfTheYear)
    }
}

extension Legacy.RecurrenceRule.End {
    
    enum CodingKeys: CodingKey {
        case endDate
        case occurrenceCount
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
            case .endDate(let date):
                try container.encode(date, forKey: .endDate)
                try container.encodeNil(forKey: .occurrenceCount)
            case .occurrenceCount(let count):
                try container.encodeNil(forKey: .endDate)
                try container.encode(count, forKey: .occurrenceCount)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let date = try container.decode(Date?.self, forKey: .endDate) {
            self = .endDate(date)
        } else if let count = try container.decode(Int?.self, forKey: .occurrenceCount) {
            self = .occurrenceCount(count)
        } else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode enum."
                )
            )
        }
    }
}

extension Legacy.RecurrenceRule: Hashable {
    
    public static func == (lhs: Legacy.RecurrenceRule, rhs: Legacy.RecurrenceRule) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(frequency)
        hasher.combine(recurrenceEnd)
        hasher.combine(interval)
        hasher.combine(offset)
        hasher.combine(firstDayOfTheWeek)
        hasher.combine(daysOfTheWeek)
        hasher.combine(daysOfTheMonth)
        hasher.combine(daysOfTheYear)
        hasher.combine(weeksOfTheYear)
        hasher.combine(monthsOfTheYear)
    }
}
