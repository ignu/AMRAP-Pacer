class TimerController < UIViewController
  def loadView
    self.view = TimerView.new
    @coach = Coach.new
  end

  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor
    super
  end

  def touchesEnded(touches, withEvent: event)
    @coach.record_round
    view.update @coach
  end
end
