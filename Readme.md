The Ruby Object Model
=====================

This is where you learn how Ruby works.
This is why the answers I give you are what they are.

Lesson Plan
-----------

* [Quiz](https://quizzes-ruby-object-model.herokuapp.com/1) <-- y'all should have memorized this shit!
* Play with hashes (linked-list style)
* Definitions
* [Quiz](https://quizzes-ruby-object-model.herokuapp.com/2)
* Anything could happen here! (we can do modules / singleton classes, or we could do [challenges](https://gist.github.com/JoshCheek/ad9f70a6d855be9ed50d))
* [Quiz](https://quizzes-ruby-object-model.herokuapp.com/3)

Definitions
-----------

### Any time you have a name, you have a hash

Any time you refer to something by name, you can think of the name as a "key",
and the thing you are referring to as a "value". Then you can represent this
with anything which can represent key/value pairs.
By far the most common way to do this, especially in Ruby, is to use a hash.
And we find that this is what makes up the things we see in Ruby.


### Objects -- the nouns of Ruby

An object is a hash with symbols for keys.
It has the keys `:class`, and `:instance_variables`.

**The purpose of an object is to store data, via its instance variables.**

If we think of the object as a **noun**, we need some **verbs** to act on it!
The verbs are methods, and those are stored in classes, not objects,
so we give each object the `:class` key,
in order to locate the methods we can call on it.

```ruby
{ class:             nil, # in reality, not nil, but one of the hashes defined below
  instance_variables: {
    :@year  => 1994,      # some example instance variables.
    :@make  => "Toyota",  # in reality, the values are other objects (other hashes like this one)
    :@model => "Camry",   # but for simplicity, I'll write them like this.
  }
}
```

### Classes -- the verbs of Ruby

A class is a hash with symbols for keys.
It has the keys `:superclass`, `:methods`, and `:constants`.

A class is also an object, which means that it also has the keys that objects have:
`:class`, and `:instance_variables`.

**The purpose of the class is to store the instructions for operating on an object.**

Each car's year may be different, which is why we store it on the object.
But each car's set of steps for incrementing the odometer are the same: `@odometer += 1`
These are methods... functions... steps... instructions... **verbs**.

If we had put them on the car itself, there would be frivolously
redundant sets of instructions on every object.
So we put the methods in one common place that all cars can go to to find: the class.

```ruby
{ # class stuff
  superclass: nil, # Look here if I don't have the method you want.
  methods:    {},  # keys are method names, as symbols, values are the method bodies
  constants:  {},  # keys are constant names, as symbols (eg :Object, :String),
                   # values are any Ruby object (ie any hash with a class and superclass)

  # object stuff
  class:              nil,
  instance_variables: {},
}
```

Note that method bodies are instructions to Ruby to do things like
"get an instance variable", "set a local variable", "call a method", etc.
If you want to see what they look like, here is some code to do it:
[https://gist.github.com/JoshCheek/a8e9dbb6f54fd1a69216](https://gist.github.com/JoshCheek/a8e9dbb6f54fd1a69216)


### Inheritance

A class "inherits" from whatever its superclass points to.
All it means is that the class can call those methods,
because that's where it will go looking next.


### Bindings -- sentences, maybe, lol

A binding is a hash with symbols for keys.
It has the keys `:self`, `:local_variables`, `:return_value`, `:next_binding`.

**The purpose of a binding is to store the information we need to actually execute the code.**

If you think of objects as **nouns** and classes as **verbs**, the binding might be your **sentence**.
If you think of objects as **ingredients** and classes as **recipes**, the binding might be your **kitchen**, your counter, a mixing bowl, your oven, a cutting board... anything which facilitates the preparation of the food according to the recipe.

* If a method says to set an instance variable,
  we need to know which object to set it on.
  So the binding has a `:self`.
* A method might need a variable that nothing else needs.
  So the binding has a hash of `:local_variables`.
* When the method is finished, it wants to send the result of its calculations
  back to the code that called it, so the binding has a `:return_value`.
* When the method is done being executed, we want the code that called it to resume execution,
  so the binding has a `:next_binding` -- the one that called it.

```ruby
{ self:            nil,      # where to set/get instance variables, find `self`, and call "implicit" methods
  local_variables: {num: 1}, # keys are variable names, values are objects (things with classes and instance variables)
  return_value:    nil,
  next_binding:    nil,
}
```

### Modules

A module is a class without the superclass.

**The purpose of a module is to store constants for namespacing,
and hold methods for "mixing into" classes.**

We'll see **why** we want these, **what** they are, and **how** how they work down below.

```ruby
{ # class stuff
  methods:    {},  # keys are method names, as symbols, values are the method bodies
  constants:  {},  # keys are constant names, as symbols (eg :Object, :String),
                   # values are any Ruby object (ie any hash with a class and superclass)

  # object stuff
  class:              nil,
  instance_variables: {},
}
```


### The stack is a linked list of bindings

The stack points at the "head" of a linked list,
this is where we are currently executing code.

When we call a method, we put a new binding on with:

* `:self` set to the object we called the method on
* `:local_variables` will have keys of the argument names, and values of whatever we passed it.
* `:return_value` set to `nil` (this is why empty methods return `nil`)
* `:next_binding` set to the binding that called it

When we leave a method, we remove the binding at the head of the list,
causing us to resume executing code at the old binding.

We call it a stack, because it nicely fits the metaphor of... stacks of things.
If you have a stack of pancakes, and you put another one on (often called pushing),
then you couldn't get to the one that used to be on top, until you took it back off
(often called popping). Anything with this behaviour of
_"the **Last** thing I put **in** is the **first** thing I get **out**"_ is a stack.
In our case, it's done with a linked list of hashes.
