class TimerController < UIViewController
  def loadView
    self.view = TimerView.new
    @coach = Coach.new
  end

  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor
    super
  end

  def prefersStatusBarHidden
    true
  end

  def touchesEnded(touches, withEvent: event)
    if @coach.timer_running?
      @coach.record_round
    else
      @coach.reset!
    end

    view.update @coach
  end
end
