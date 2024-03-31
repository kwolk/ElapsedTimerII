I always find it annoying to see a timer finished and not know when it had finished.

With this concept it is possible to see how many seconds have since elapsed after the timer finished:

![elapsedTimerII](https://github.com/kwolk/ElapsedTimerII/assets/114968/30aa234e-6a04-4a6d-b8d2-6adf62c620b6)

Simply drag the blue box up to the desired time (it only goes up to five seconds on the iPod 7th generation screen as it takes 100px for a second, but your iDevice may have more pixels to play with) and let it fall.

When it reaches the bottom the counter reach zero and then begin to count upwards to let you know how long it has been since it finished.

_note : I cannot get the blue bar to remain at zero at the bottom from the outset with the final code, so I commented out the original code that was more reliable (but didn't have a timer). All that is needed to be done is to swipe the blue box down at runtime and then it will function correctly. The issue is the offset modifier, which if changed messes around with the animation logic._
