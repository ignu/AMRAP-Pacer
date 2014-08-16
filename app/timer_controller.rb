class TimerController < UIViewController
  def loadView
    self.view = TimerView.new
  end

  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor
    super
  end
end
