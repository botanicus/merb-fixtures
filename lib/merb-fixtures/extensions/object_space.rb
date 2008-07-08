module ObjectSpace
  def self.each_class(&block)
    ObjectSpace.each_object(Class) do |klass|
      block.call(klass) if block_given?
    end
  end
end