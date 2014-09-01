class SettingsController < Formotion::FormController
  GREEN_COLOR   = [189, 179, 170].uicolor

  def shouldAutorotate
    false
  end

  def initialize(coach)
    @coach = coach
    self.initWithForm(self.form)

    self.form.on_submit do |form|
      @coach.update_settings(form.render)
      self.reset_coach
    end
  end

  def loadView
    super

    view.on_swipe :right do |gesture|
      nav_controller.toolbarHidden = true
      nav_controller.pop
    end
  end

  def viewDidLoad
    super
    view.addSubview(@toolbar = UIToolbar.new)
    @toolbar.frame = [[0, self.view.frame.size.height-130], [320, 100]]

    @toolbar.tintColor = GREEN_COLOR

    @toolbar.setItems([
      UIBarButtonItem.alloc.initWithTitle(
        "Reset",
        style: UIBarButtonItemStylePlain,
        target: self,
        action: 'reset_coach'
      ),
      UIBarButtonItem.alloc.initWithBarButtonSystemItem(
        UIBarButtonSystemItemFlexibleSpace,
        target: nil,
        action: nil
      ),
      UIBarButtonItem.alloc.initWithTitle(
        "Twitter",
        style: UIBarButtonItemStylePlain,
        target: self,
        action: 'twitter'
      )
    ])
  end

  def twitter
    nativeUrl = NSURL.alloc.initWithString "twitter://user?screen_name=ignu"
    webUrl = NSURL.alloc.initWithString "http://twitter.com/ignu"

    app = UIApplication.sharedApplication

    app.openURL(webUrl) unless app.openURL(nativeUrl)
  end

  def form
    @form ||= Formotion::Form.new({
      title: "Round Info",
      sections: [{
        title: "Round Info",
        footer: "The progress bar will update to keep you on track to this goal. Leave these blank to set the round's goal based on your current average.",
        rows: [{
          title: "Minutes",
          key: :minutes,
          placeholder: "20",
          image: "time",
          value: @coach.minutes,
          type: :number,
          input_accessory: :done
        }, {
          title: "Goal Rounds",
          key: :goal,
          placeholder: "14",
          image: "goal",
          type: :number,
          value: @coach.goal,
          input_accessory: :done
        }, {
          title: "Show Timer?",
          key: :show_timer,
          value: @coach.show_timer,
          type: :switch,
        },
        {
          title: "Save",
          type: :submit,
        }
        ]
      }]
})
  end

  def reset_coach
    @coach.reset!
    nav_controller.toolbarHidden = true
    self.nav_controller.pop
  end

  def nav_controller
    UIApplication.sharedApplication.keyWindow.rootViewController
  end
end
