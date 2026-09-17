# Local preview only (loaded by bin/preview). See the comment there.
class Object
  def tainted? = false unless method_defined?(:tainted?)
end
