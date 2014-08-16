describe "Coach" do
  before do
    @coach = Coach.new
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
      @coach.record_round
    end

    it "increments the count" do
      @coach.rounds_count.should == 1
    end
  end
end
