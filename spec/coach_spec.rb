describe "Coach" do
  before do
    @coach = Coach.new
    @start = Time.now
    @coach.start!
  end

  context "with zero rounds" do
    it "does not have an average" do
      @coach.average.should == nil
    end

    it "has zero rounds" do
      @coach.average.should == nil
    end
  end

  describe "reset!" do
    it "sends a message on NSNotificationCenter" do
      x = 1

      App.notification_center.observe "ResetTimer" do |n|
        x = x + 1
      end

      x.should == 1
      @coach.reset!
      x.should == 2
    end

    App.notification_center.unobserve "ResetTimer"
  end

  describe "round_goal" do
    context "given a goal and a time" do
      before do
        @coach.update_settings({
          goal: "10",
          minutes: "10"
        })
      end

      it "calculates the speed you need to reach the goal" do
        @coach.round_goal.should == 60

        5.times { |n| @coach.record_round }
        @coach.stub!(:get_time, return: @start + 60 * 9)

        # 5 rounds in 60 seconds
        @coach.round_goal.to_i.should == 12

        5.times { |n| @coach.record_round }
        @coach.round_goal.to_i.should == (60*9)/10
      end
    end
  end

  describe "record_round" do
    before do
      @coach.stub!(:get_time, return: @start)
      @coach.start!

      @coach.record_round
      @coach.stub!(:get_time, return: @start + 29.3)
      @coach.record_round
    end

    it "increments the count" do
      @coach.rounds_count.should == 2
    end

    it "records the round time" do
      @coach.average.should == 15
    end
  end
end
