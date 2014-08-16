class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    vc = TimerController.new

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = vc
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
  end
end
