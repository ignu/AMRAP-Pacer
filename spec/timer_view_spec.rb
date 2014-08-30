describe TimerView do
  describe "#print_time" do
    it "can format time from seconds" do
      view = TimerView.new
      view.print_time(50).should == "0:50"
      view.print_time(70).should == "1:10"
    end
  end
end
