class SettingsController < Formotion::FormController
  def initialize(coach)
    @coach = coach
    self.initWithForm(self.form)

    self.form.on_submit do |form|
      @coach.update_settings(form.render)
    end
  end

  def loadView
    super

    view.on_swipe :right do |gesture|
      nav_controller.pop
    end
  end


  def viewDidLoad
    super
    add_reset_button
  end

  def add_reset_button
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle("Reset", forState:UIControlStateNormal)
    button.setTitle("Reset", forState:UIControlStateSelected)
    button.frame = [[0, self.view.frame.size.height-100], [320, 100]]
    button.setBackgroundColor :white.uicolor

    button.on :touch do
      self.reset_coach
    end

    self.view.addSubview(button)
  end

  def form
    @form ||= Formotion::Form.new({
      title: "Round Info",
      sections: [{
        title: "Round Info",
        footer: "The progress bar will update to keep you on track to this goal. Leave these blank to set the goal based on your current progress.",
        rows: [{
          title: "Time",
          key: :time,
          placeholder: "20:00",
          image: "time",
          type: :string,
          input_accessory: :done
        }, {
          title: "Goal Rounds",
          key: :goal,
          placeholder: "14",
          image: "goal",
          type: :number,
          input_accessory: :done
        }, {
          title: "Show Timer?",
          key: :show_timer,
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
  end

  def nav_controller
    UIApplication.sharedApplication.keyWindow.rootViewController
  end
end
