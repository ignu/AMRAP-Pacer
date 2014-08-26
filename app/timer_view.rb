class TimerView < UIView
  attr_accessor :counter_label

  def drawRect(rect)
    super rect
    create_counter_label
    create_average_label
    clear_progress_view
    create_timer_label
    self.create_goal_label
  end

  def create_counter_label
    @counter_label.removeFromSuperview unless  @counter_label.nil?
    @counter_label = UILabel.new
    @counter_label.text = "Start"
    @counter_label.frame = self.frame
    @counter_label.adjustsFontSizeToFitWidth = true
    @counter_label.font = UIFont.fontWithName("TrebuchetMS", size: 128)
    @counter_label.textAlignment = NSTextAlignmentCenter

    self.addSubview(@counter_label)
  end

  def create_average_label
    @average_label.removeFromSuperview unless @average_label.nil?
    @average_label = UILabel.new
    @average_label.text = "Swipe for options"
    @average_label.frame = [[0, self.frame.size.height-150], [320, 100]]
    @average_label.adjustsFontSizeToFitWidth = true
    @average_label.font = UIFont.fontWithName("TrebuchetMS", size: 28)
    @average_label.textAlignment = NSTextAlignmentCenter

    self.addSubview(@average_label)
  end

  def create_goal_label
    @goal_label.removeFromSuperview unless @goal_label.nil?
    @goal_label = UILabel.new
    @goal_label.text = ""
    @goal_label.frame = [[0, self.frame.size.height-100], [320, 100]]
    @goal_label.adjustsFontSizeToFitWidth = true
    @goal_label.font = UIFont.fontWithName("TrebuchetMS", size: 28)
    @goal_label.textAlignment = NSTextAlignmentCenter

    self.addSubview(@goal_label)
  end

  def create_timer_label
    @timer_label.removeFromSuperview unless @goal_label.nil?
    @timer_label = UILabel.new
    @timer_label.text = ""
    @timer_label.frame = [[0, 10], [320, 100]]
    @timer_label.adjustsFontSizeToFitWidth = true
    @timer_label.font = UIFont.fontWithName("TrebuchetMS", size: 42)
    @timer_label.textAlignment = NSTextAlignmentCenter

    self.addSubview(@timer_label)
  end

  def toggle_timer
    return unless @coach.show_timer
    @timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector:'timerFired', userInfo:nil, repeats:true)
  end

  def timerFired
    return unless @coach.show_timer
    return if @coach.current_time.nil?
    @timer_label.text = self.print_time(@coach.current_time.to_i)
  end

  def update(coach)
    @coach ||= coach
    @counter_label.text = coach.rounds_count.to_s
    toggle_timer if coach.rounds_count == 0
    if coach.average.nil?
      @average_label.text = ""
    else
      @average_label.text = "Average: #{self.print_time coach.average}"
    end

    unless coach.round_goal.nil?
      @goal_label.text = "Goal: #{self.print_time coach.round_goal}" unless coach.round_goal.nil?
      add_progress_view(coach.round_goal)
    end
  end

  def print_time(seconds)
    return if seconds.nil?
    minutes = seconds/60
    remainder = seconds - (minutes*60)
    "#{minutes.to_s.rjust(2, '0')}:#{remainder.to_s.rjust(2, '0')}"
  end

  def clear_progress_view
    @progress_view.removeFromSuperview if @progress_view
  end

  def add_progress_view(seconds)
    self.becomeFirstResponder()
    clear_progress_view

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
