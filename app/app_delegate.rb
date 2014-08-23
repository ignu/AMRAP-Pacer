
class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    coach = Coach.new
    vc = TimerController.new coach

    nc = UINavigationController.alloc.initWithRootViewController vc

    coach.on_reset do
     vc = TimerController.new coach
     nc.pop
     nc.push vc
    end


    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = nc

    nc.setNavigationBarHidden true

    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
  end
end
