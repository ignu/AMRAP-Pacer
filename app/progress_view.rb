class ProgressView < UIView
  BACKGROUND_COLOR = [ 136, 140, 3].uicolor

  def drawRect(rect)
    self.setBackgroundColor BACKGROUND_COLOR
  end
end

