class TimerView < UIView
  attr_accessor :counter_label
  PRIMARY_LABEL_COLOR   = UIColor.blackColor
  SECONDARY_LABEL_COLOR = UIColor.blackColor

  def drawRect(rect)
    reset_timer
    super rect
    create_counter_label
    create_average_label
    clear_progress_view
    create_timer_label
    self.create_goal_label
    setup_layout
  end

  def setup_layout
    Motion::Layout.new do |layout|
      layout.view self
      layout.subviews({
        "timer"   => @timer_label,
        "counter" => @counter_label,
        "average" => @average_label,
        "goal"    => @goal_label
      })

      layout.metrics({
        "margin" => 10,
        "portraitTopMargin" => ((self.frame.size.height - 100) / 2),
        "landscapeBottomMargin" => ((self.frame.size.width - 360) / 2)
      })

      layout.vertical "|-20-[counter]-(>=landscapeBottomMargin)-[timer]-5-[average]-5-[goal]-15-|"

      layout.horizontal "|-margin-[timer]-margin-|"
      layout.horizontal "|-margin-[counter]-margin-|"
      layout.horizontal "|-margin-[average]-margin-|"
      layout.horizontal "|-margin-[goal]-margin-|"

    end
  end

  def create_counter_label
    @counter_label.removeFromSuperview unless  @counter_label.nil?
    @counter_label = UILabel.new
    @counter_label.text = "Start"
    @counter_label.color = PRIMARY_LABEL_COLOR
    @counter_label.frame = [[0, 10], [0, 0]]
    @counter_label.adjustsFontSizeToFitWidth = true
    @counter_label.font = UIFont.fontWithName("TrebuchetMS", size: 128)
    @counter_label.textAlignment = NSTextAlignmentCenter

    self.addSubview(@counter_label)
  end

  def create_average_label
    @average_label.removeFromSuperview unless @average_label.nil?
    @average_label = UILabel.new
    @average_label.text = "Swipe for options"
    @average_label.color = SECONDARY_LABEL_COLOR
    @average_label.frame = [[0, self.frame.size.height-150], [0, 0]]
    @average_label.adjustsFontSizeToFitWidth = true
    @average_label.font = UIFont.fontWithName("TrebuchetMS", size: 28)
    @average_label.textAlignment = NSTextAlignmentCenter

    self.addSubview(@average_label)
  end

  def create_goal_label
    @goal_label.removeFromSuperview unless @goal_label.nil?
    @goal_label = UILabel.new
    @goal_label.text = ""
    @goal_label.color = SECONDARY_LABEL_COLOR
    @goal_label.frame = [[0, self.frame.size.height-100], [0, 0]]
    @goal_label.adjustsFontSizeToFitWidth = true
    @goal_label.font = UIFont.fontWithName("TrebuchetMS", size: 28)
    @goal_label.textAlignment = NSTextAlignmentCenter

    self.addSubview(@goal_label)
  end

  def create_timer_label
    @timer_label.removeFromSuperview unless @goal_label.nil?
    @timer_label = UILabel.new
    @timer_label.text = ""
    @timer_label.color = SECONDARY_LABEL_COLOR
    @timer_label.frame = [[0, 10], [0, 0]]
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

  def reset_timer
    return if @timer.nil?
    @timer.invalidate
    @timer = nil
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
      add_progress_view
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


  def add_progress_view
    return if @coach.nil?

    self.becomeFirstResponder()
    clear_progress_view

    starting_percent = 1 - @coach.remaining_percent
    p "starting_percent: #{starting_percent}"
    p "height: #{height}"
    p '-' * 88

    height = (starting_percent * self.frame.size.height).to_i
    height = 1 if height == 0
    height = self.frame.size.height if starting_percent < 0
    rect = CGRectMake(0, 0, self.frame.size.width, height)

    @progress_view = ProgressView.alloc.initWithFrame(rect)

    if starting_percent >= 0
      animate_progress_view
    else
      @progress_view.backgroundColor = UIColor.redColor()
    end

    self.addSubview @progress_view
    self.sendSubviewToBack @progress_view
  end

  def animate_progress_view
    @progress_view.backgroundColor = UIColor.greenColor()
    UIView.animateWithDuration(@coach.remaining_seconds_in_round,
      delay: 0,
      options: UIViewAnimationOptionAllowUserInteraction,

      animations: -> do
        @progress_view.height = self.height
      end,

      completion: -> (finished) {
        @progress_view.backgroundColor = UIColor.redColor() if finished
      }
    )
  end
end
