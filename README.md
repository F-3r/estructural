# Estructural

A quick way to define estructured, data-container objects drawing inspiration from `Struct` and `OpenStruct`

## Motivation

When drafting ideas in code I usually find myself writting several classes that are data wrappers with a little tiny logic like:

```ruby
class Dog
  attr_accessor :breed, :size

  def initialize(params = {})
    @breed = params[:breed]
    @size = params[:size]
  end
end
```

For things like this I prefer struct, as it lets me define the attributes and methods of the class easily, but I prefer the keyword arguments rather than positional arguments.

I like the initializer of `OpenStruct` but they don't have a defined structure. (Eg. you can easily misstype an attribute and you won't easily realize until a `NoMethodError (undefined method `x' for nil:NilClass`)) and they are all instances of the same OpenStruct class.


Estructural borrows the structure declaration of Struct and the initializer of OpenStruct, to define a class as if you have written the class by hand.

## Usage

```ruby
Dog = Estructural.new(:breed, :size)

fer = Dog.new(breed: 'toomucher retriever', size: 'he just fits in')
```

This generate a `Dog` class, that has `@breed` and `@size` instance variables and it's accessors

```ruby
fer.breed #=> 'toomucher retriever'
fer.size #=> 'he just fits in'

fer.breed = "I'm a cat"
fer.breed #=> "I'm a cat"
```

If you need default values, you can specify them as keyword arguments:


```ruby
Dog = Estructural.new(:breed, size: "big enough")

fer = Dog.new(breed: 'toomucher retriever')

fer.size #=> "big enough"
```

If you need to add more methods, you can pass a block to the definition:

```ruby
Dog = Estructural.new(:breed, :size) do
  def bark!
    "to leave or not to leave the couch, that's the question."
  end
end

fer = Dog.new(breed: 'toomucher retriever', size: 'he just fits in')

fer.respond_to? :bark! #=> true
fer.bark! #=> "to leave or not to leave the couch, that's the question."
```

## Contributing

Forks, Clones, Issues, Stars, Hugs, Beers, Whatever, all are all welcome.

## License

AGPLV3. See `LICENSE` for details.
