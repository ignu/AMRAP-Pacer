class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    coach = Coach.new
    vc = TimerController.new coach

    nc = UINavigationController.alloc.initWithRootViewController vc

    App.notification_center.observe "ResetTimer" do |n|
      p "timer reset ...."
      vc.view.setNeedsDisplay
    end

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = nc

    nc.setNavigationBarHidden true

    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
  end
end
