object = {
  human_name: 'Object',    # => "Object"
  methods: {to_s: '...'},  # => {:to_s=>"..."}
}                          # => {:human_name=>"Object", :methods=>{:to_s=>"..."}}

car = {
  human_name: 'Car',           # => "Car"
  superclass:  object,         # => {:human_name=>"Object", :methods=>{:to_s=>"..."}}
  methods:    {drive: '...'},  # => {:drive=>"..."}
}                              # => {:human_name=>"Car", :superclass=>{:human_name=>"Object", :methods=>{:to_s=>"..."}}, :methods=>{:drive=>"..."}}

some_car = {
  class: car,                                            # => {:human_name=>"Car", :superclass=>{:human_name=>"Object", :methods=>{:to_s=>"..."}}, :methods=>{:drive=>"..."}}
  instance_variables: {:@mileage => 1000, :@year => 5},  # => {:@mileage=>1000, :@year=>5}
}                                                        # => {:class=>{:human_name=>"Car", :superclass=>{:human_name=>"Object", :methods=>{:to_s=>"..."}}, :methods=>{:drive=>"..."}}, :instance_variables=>{:@mileage=>1000, :@year=>5}}

some_car[:instance_variables]                       # => {:@mileage=>1000, :@year=>5}
some_car[:class][:superclass][:methods].key? :to_s  # => true
class Object
  public :to_s
end

class Car
  def initialize
    @mileage = 1000  # => 1000
    @year = 5        # => 5
  end                # => :initialize

  def drive
  end        # => :drive
end          # => :drive

car = Car.new           # => #<Car:0x007fd29b8cf080 @mileage=1000, @year=5>
car.instance_variables  # => [:@mileage, :@year]
car.class.superclass.instance_methods(false)   # => [:to_s]

