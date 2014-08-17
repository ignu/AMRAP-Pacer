describe "Coach" do
  before do
    @coach = Coach.new
    @start = Time.now
    @coach.reset!
  end

  context "with zero rounds" do
    it "does not have an average" do
      @coach.average.should == nil
    end

    it "has zero rounds" do
      @coach.average.should == nil
    end
  end

  describe "record_round" do
    before do
      @coach.stub!(:get_time, return: @start)
      @coach.reset!

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
