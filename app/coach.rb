class Coach
  attr_accessor :rounds_count, :goal, :minutes, :show_timer, :last_round_time

  def initialize
    @show_timer = true
    self.last_round_time = 0
  end

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
    self.show_timer = hash[:show_timer]
  end

  def round_goal
    return self.average if self.goal.nil?

    # avoid divide by zero errors and negative times
    return self.average if self.remaining_rounds_for_goal < 1

    remaining_time = (self.minutes.to_i * 60) - self.last_round_time
    (remaining_time / self.remaining_rounds_for_goal).round(0)
  end

  def remaining_rounds_for_goal
    self.goal.to_i - self.rounds_count
  end

  def remaining_seconds_in_round
    return nil unless self.round_goal

    p "self.current_round_time: #{self.current_round_time}"

    (self.round_goal - self.current_round_time).round(0)
  end

  def remaining_percent
    return nil unless self.round_goal
    return 100 if self.remaining_seconds_in_round <=0

    p "percent calc: #{self.remaining_seconds_in_round.to_f}/#{self.round_goal}=#{self.remaining_seconds_in_round.to_f/self.round_goal}"
    self.remaining_seconds_in_round.to_f/self.round_goal
  end

  def average
    return nil unless self.rounds_count > 0
    result = self.last_round_time / self.rounds_count

    result.round(0)
  end

  def current_time
    return get_time if @start_time.nil?

    (get_time - @start_time)
  end

  def current_round_time
    return current_time if self.rounds_count < 1

    (current_time - self.last_round_time)
  end

  def record_round
    p "record-round ---------------------------------------"
    ensure_timer_running
    self.last_round_time = self.current_time
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
