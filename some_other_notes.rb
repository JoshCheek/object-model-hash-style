# Whenever you name a thing...
# you can represent it with a hash!
#
# The name becomes the key
# the "thing" becomes the value

list = {
  head: {
    data: 'hello',
    link: {
      data: 'world',
      link: {
        data: '!',
        link: nil,
      }
    }
  }
}

list[:head][:link][:link]
# => {:data=>"!", :link=>nil}



{ mileage: 50_000,
  year:    1936,
}

class Car
  def drive(distance)
    @mileage += distance
  end
  @hello = 'world'
end

Car.instance_variables # => [:@hello]

# An example Car class
Car = {
  superclass: ??,
  constants: {},
  methods: {
    drive: 'receive the distance,
            increment @mileage by the distance'
  },
  instance_variables: {:@hello => 'world'},
  class:              Class,
}

Class.superclass # => Module
     .superclass # => Object
     .superclass # => BasicObject


# An example of an instance of Car
{ instance_variable: {
    :@mileage => 50_000,
    :@year    => 1936,
    :@colour  => :red_or_something,
  },
  class: Car
}
