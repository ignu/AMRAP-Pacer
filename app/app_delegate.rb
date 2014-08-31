class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    coach = Coach.new
    vc = TimerController.new coach

    nc = UINavigationController.alloc.initWithRootViewController vc

    App.notification_center.observe "ResetTimer" do |n|
      vc.view.setNeedsDisplay
    end

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = nc

    nc.setNavigationBarHidden true

    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
  end

  # weird things happen with timers when the application goes in the background.
  #
  # just reset the timer.
  def applicationDidEnterBackground(application)
    @coach.reset! unless @coach.nil?
  end
end
