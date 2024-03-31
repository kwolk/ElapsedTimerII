//
//  ContentView.swift
//  ElapsedTimerII
//
//  Created by Samuel Corke on 29/03/2024.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            DraggableView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
        .edgesIgnoringSafeArea(.all)
    }
}

struct DraggableView: View {
    
    enum TimerDirection { case up, down }
    
    @State var position : CGFloat   = UIScreen.main.bounds.height - (UIScreen.main.bounds.height / 7)
    @State var height   : CGFloat   = 50     // SET SPACE FROM BOTTOM
    @State var offset   : CGFloat   = 0      // OFFSET VALUE
    @State var countDown: Int       = 0
    @State var timer    : Timer?    = nil

    var body: some View {
        
        counterBlock    // DRAGGABLE TIMER BLOCK
    }
    
    
    var counterBlock: some View {
        Text("\(countDown) sec") // COUNTER BEGINS TO COUNT UP (ELAPSED TIME) AFTER REACHING ZERO
            .frame(width: UIScreen.main.bounds.width / 2, height: height)  // DYNAMIC HEIGHT CALCULATED ON CHANGE EVENT
            .frame(maxWidth: .infinity)
            .position(x: UIScreen.main.bounds.width / 2, y: height / 2)     // ENSURES TEXT (TIMER) ALIGNS TO TOP CENTRE OF FRAME
            .background(.blue)
            .foregroundColor(.yellow)
            .offset(y: max(offset, 0))  // CALCULATE THE AMOUNT TO MOVE BY
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        // MINIMUM OF 50 RESPECTED, WITH NEW HEIGHT ACCRUED FROM GESTURE
                        height = max(50, height - value.location.y)
                        offset = value.location.y   // STORE NEW OFFSET
                        
                        let distance = Int(UIScreen.main.bounds.height - offset)
                        countDown = distance / 100  // 100px : 1 sec
                        invalidateTimer()           // RESET TIMER FOR NEW GESTURE POSITIONING
                    })
                
                    .onEnded { value in
                        // ANIMATE DECLINE TO WITNESS TIMER COUNTING DOWN
                        withAnimation(Animation.easeInOut(duration: Double(countDown))) {
                            offset = UIScreen.main.bounds.height - height   // DECLINE WILL RESPECT BOTTOM SPACING (DISPLAYING TIMER)
                        }

                        // TIMER COUNTS DOWN SECONDS (CALCULATED FROM 100px VALUES)
                        startTimer(.down)
                            
                        // IF TIMER FINISHED THEN ELAPSED SECONDS BEGIN
                        if countDown <= 0 {
                            startTimer(.up)
                        }
                    })
    }
    
    // TIMER (UP/DOWN)
    func startTimer(_ set: TimerDirection) {
        invalidateTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if set == .up {
                countDown += 1
            } else {
                countDown -= 1
                // WORKAROUND : ENSURE COUNTER DOES NOT STRAY INTO NEGATIVE COUNTING BY INVALIDATING TIMER SEPARATELY
                if countDown <= 0 {
                    invalidateTimer()
                    startTimer(.up)
                }
            }
        }
    }
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
}





// FASTER DRAGGING OPTION (BUT NOT ANIMATION)
// NO ISSUES WITH RESIZING AS THERE IS NO onEnded EVENT THAT SETS THE SIZE
// THE SIZE FLEXES RELIABLY AND QUICKLY AND NEED NOT WAIT TO RESET ITS SIZE

/*
struct DraggableView: View {
    @State var rectangleHeight: CGFloat = 50    // SET SPACE FROM BOTTOM
    @State var offset: CGFloat = 0              // OFFSET VALUE
    @State var countDown: Int = 0
    @State var timer: Timer? = nil

    var body: some View {
        Text("\(countDown) sec")
            .frame(width: UIScreen.main.bounds.width, height: rectangleHeight)  // DYNAMIC HEIGHT CALCULATED ON CHANGE EVENT
            .frame(maxWidth: .infinity)
            .background(.blue)
            .foregroundColor(.yellow)
            .offset(y: max(offset, 0))
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        rectangleHeight = max(50, rectangleHeight - value.location.y) // MINIMUM OF 50 RESPECTED, WITH NEW HEIGHT ACCRUED FROM GESTURE
                        offset = value.location.y   // STORE NEW OFFSET
                        
                        let distance = Int(UIScreen.main.bounds.height - offset)
                        countDown = distance / 100  // 100px : 1 sec
                        timer?.invalidate()
                        timer = nil
                    })
                
            )
    }
}
*/

