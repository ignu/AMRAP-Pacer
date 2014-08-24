class Coach
  attr_accessor :rounds_count, :goal, :minutes, :show_timer

  def reset!
    @start_time = nil
    self.rounds_count = 0
    App.notification_center.post "ResetTimer"
  end

  def start!
    self.rounds_count = 0
    @start_time = get_time
  end

  def update_settings(hash)
    self.goal = hash[:goal]
    self.minutes = hash[:minutes]
  end

  def round_goal
    return self.average if self.goal.nil?

    # avoid divide by zero errors and negative times
    return self.average if self.remaining_rounds_for_goal < 1

    (self.remaining_time / self.remaining_rounds_for_goal).round(0)
  end

  def remaining_time
    (self.minutes.to_i * 60) - self.current_time
  end

  def remaining_rounds_for_goal
    self.goal.to_i - self.rounds_count
  end

  def average
    return nil unless self.rounds_count > 0
    result = current_time / self.rounds_count
    result.to_i
  end

  def current_time
    (get_time - @start_time + 1)
  end

  def record_round
    ensure_timer_running
    self.rounds_count = self.rounds_count + 1
  end

  def get_time
    Time.now
  end

  def ensure_timer_running
    raise "Please start the timer with #reset!" unless timer_running?
  end

  def timer_running?
    !!@start_time
  end
end
