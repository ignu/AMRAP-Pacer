class SettingsView < UIView
  attr_accessor :counter_label

  def drawRect(rect)
    super rect
    self.add_reset_button
  end

  def add_reset_button
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.setTitle("Reset", forState:UIControlStateNormal)
    button.setTitle("Reset", forState:UIControlStateSelected)
    button.frame = [[0, self.frame.size.height-100], [320, 100]]
    button.setBackgroundColor :white.uicolor

    self.addSubview(button)
  end
end
