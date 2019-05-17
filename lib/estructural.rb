class Estructural
  VERSION = '0.0.1'

  def self.new(*attributes, **defaults, &block)
    Class.new do
      (attributes + defaults.keys).each do |attr|
        define_method(attr) { instance_variable_get("@#{attr}") }
        define_method("#{attr}=") {|value| instance_variable_set("@#{attr}", value) }
      end

      define_method(:initialize) do |args = {}|
        defaults.each { |attribute, value| send("#{attribute}=", value.dup) }
        args.each { |attribute, value| send "#{attribute}=", value }
      end

      class_eval(&block) if block
    end
  end
end
