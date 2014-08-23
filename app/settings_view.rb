class SettingsView < UIView
  def drawRect(rect)
    super rect
    self.add_reset_button
    self.render_form
  end

  def render_form
    p '-' * 88
    p "form.render: #{form.render}"
  end

  def submit
  end

  def add_reset_button
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle("Reset", forState:UIControlStateNormal)
    button.setTitle("Reset", forState:UIControlStateSelected)
    button.frame = [[0, self.frame.size.height-100], [320, 100]]
    button.setBackgroundColor :white.uicolor

    button.on :touch do
      self.controller.reset_coach
    end

    self.addSubview(button)
  end
end
