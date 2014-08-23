class SettingsController < UIViewController
  def initialize(coach)
    @coach = coach
  end

  def loadView
    self.view = SettingsView.new

    view.on_swipe :right do |gesture|
      nav_controller.pop
    end
  end

  def viewDidLoad
    view.backgroundColor = UIColor.blackColor
    super
  end

  def prefersStatusBarHidden
    true
  end

  def reset_coach
    @coach.reset!
  end

  def nav_controller
    UIApplication.sharedApplication.keyWindow.rootViewController
  end
end
