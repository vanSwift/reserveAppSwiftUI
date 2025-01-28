//
//  TimeslotCell.swift
//  reserveAppSwiftUI
//
//  Created by Иван Терехов on 24.01.2025.
//

import Foundation
import SwiftUI

struct TimeslotCell: View {
    @State var observed: Observed
    var body: some View {
        VStack(alignment:.leading, spacing: 5) {
            Text(observed.timeLable )
                .fontWeight(.bold)
                .font(.title3)

            Text(observed.isFreeDescription)
        }
        .padding()
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(observed.bgColor)
        .clipShape(RoundedRectangle(cornerRadius: 15 ))
        
        .offset(x: 60)
    }
}

extension TimeslotCell{
    @Observable
    class Observed{
        var timeslot: Timeslot
        var timeLable:String { "\(timeslot.startTime.formatted(date: .omitted, time: .shortened)) - \(timeslot.endTime.formatted(date: .omitted, time: .shortened))"}
        
        init(timeslot: Timeslot) {
            self.timeslot = timeslot
        }
        
                
        var isFreeDescription: String{
            guard timeslot.clientId != nil else {
                return "Час вільний!"
            }
            if timeslot.clientId == Timeslot.userId{
                return "Ви записани на цей час"
            }
            else{
               return "Час зайнятий"
            }
        }
        var bgColor: Color  {
            if timeslot.clientId == nil{
                return .greenstatus
            }
            return timeslot.clientId == Timeslot.userId ? .yellowstatus : .orangestatus
        }

    }
}

#Preview(body: {
    TimeslotCell(observed: .init(timeslot: .init(startTime: .now, masterId: UUID())))
})
