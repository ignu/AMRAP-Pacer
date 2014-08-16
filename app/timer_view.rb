class TimerView < UIView
  attr_accessor :counter_label

  def drawRect(rect)
    super rect
    create_counter_label
  end

  def create_counter_label
    counter_label = UILabel.new
    counter_label.text = "0"
    counter_label.frame = self.frame
    counter_label.adjustsFontSizeToFitWidth = true
    counter_label.font =  UIFont.fontWithName("Arial", size:64)


    self.addSubview(counter_label)
  end
end
