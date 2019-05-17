require "minitest/autorun"

require_relative "../lib/estructural"

describe Estructural do
  Subject = Estructural.new(:name, :id, things: []) do
    def serialize
      "id:#{id} name:#{name}"
    end
  end

  it "accepts a hash of attributes" do
    instance = Subject.new(id: 1, name: "a subject has no name")
  end

  it "generates corresponding getters" do
    instance = Subject.new(id: 1, name: "a subject has no name")

    instance.name.must_equal "a subject has no name"
    instance.id.must_equal 1
  end

  it "generates the corresponding setters" do
    instance = Subject.new(id: 1, name: "a subject has no name")
    instance.name = "a name"
    instance.id = 0

    instance.name.must_equal "a name"
    instance.id.must_equal 0
  end

  it "raises when accessing a non existent attribute" do
    instance = Subject.new(id: 1, name: "a subject has no name")

    -> { instance.address }.must_raise NoMethodError
    -> { instance.address = "nowhere" }.must_raise NoMethodError
  end

  it "defines the methods in the block" do
    instance = Subject.new(id: 1, name: "a subject has no name")
    instance.must_respond_to :serialize
    instance.serialize.must_equal "id:1 name:a subject has no name"
  end

  it "assgins default values" do
    instance = Subject.new(id: 1, name: "1")
    instance2 = Subject.new(id: 1, name: "1")

    instance.things.must_equal []
    instance2.things.must_equal []

    instance.things << 1
    instance.things << 3
    instance.things << 5


    instance2.things << 2
    instance2.things << 4
    instance2.things << 6

    instance.things.must_equal [1,3,5]
    instance2.things.must_equal [2,4,6]
  end

  it "assgins default values are overriden in initialize" do
    instance = Subject.new(id: 1, name: "1", things: "a smoke")
    instance.things.must_equal "a smoke"
  end
end
