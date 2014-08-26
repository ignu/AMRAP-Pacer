describe "TimerController" do
  tests TimerController

  describe "start up" do
    before do
      @coach = Coach.new
      @coach.goal = 10
      @coach.minutes = 20
      controller.instance_variable_set "@coach", @coach
      tap("Start")
    end

    it "displays start text and goal" do
      view("0").nil?.should == false
      view("Goal: 02:00").nil?.should == false
    end
  end
end
