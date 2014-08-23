class TimerController < UIViewController
  def initialize(coach)
    @coach = coach
  end

  def loadView
    self.view = TimerView.new
  end

  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor
    view.on_swipe :left do |gesture|
      new_vc = SettingsController.new(@coach)
      nav_controller.push new_vc
    end
    super
  end

  def prefersStatusBarHidden
    true
  end

  def nav_controller
    UIApplication.sharedApplication.keyWindow.rootViewController
  end

  def touchesEnded(touches, withEvent: event)
    if @coach.timer_running?
      @coach.record_round
    else
      @coach.reset!
    end

    self.view.update @coach
  end
end
