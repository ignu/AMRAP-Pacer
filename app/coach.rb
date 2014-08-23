class Coach
  attr_accessor :rounds_count

  def reset!
    @start_time = nil
    self.rounds_count = 0
    App.notification_center.post "ResetTimer"
  end

  def start!
    self.rounds_count = 0
    @start_time = get_time
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
