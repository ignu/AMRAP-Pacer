class TimerView < UIView
  attr_accessor :counter_label

  def drawRect(rect)
    super rect
    create_counter_label
  end

  def create_counter_label
    @counter_label = UILabel.new
    @counter_label.text = "Start"
    @counter_label.frame = self.frame
    @counter_label.adjustsFontSizeToFitWidth = true
    @counter_label.font = UIFont.fontWithName("Arial", size: 64)
    @counter_label.textAlignment = NSTextAlignmentCenter

    self.addSubview(@counter_label)
  end

  def update(coach)
    @counter_label.text = coach.rounds_count.to_s
    add_progress_view(coach.average) if coach.rounds_count > 0
  end

  def add_progress_view(seconds)
    self.becomeFirstResponder()

    @progress_view.removeFromSuperview if @progress_view

    rect = CGRectMake(0, 0, self.frame.size.width, 1)
    @progress_view = ProgressView.alloc.initWithFrame(rect)
    @progress_view.backgroundColor = UIColor.greenColor()

    UIView.animateWithDuration(seconds,
      delay: 0,
      options: UIViewAnimationOptionAllowUserInteraction,

      animations: -> do
        @progress_view.height = self.height
      end,

      completion: -> (finished) {
        @progress_view.backgroundColor = UIColor.redColor() if finished
      }
    )

    self.addSubview @progress_view
    self.sendSubviewToBack @progress_view
  end
end
