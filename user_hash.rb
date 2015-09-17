basic_object_class = {
  superclass: nil,
  methods: {
    :equal? => "...equal?..."
  },
}

object_class = {
  superclass: basic_object_class,
  methods: {
    to_s: "...to_s..."
  },
}

user_class = {
  superclass: object_class,
  methods:  {
    birthday: "@age += 1"
  },
}

some_user = {
  class: user_class,
  instance_variables: {:@age  => 123}
}

some_user[:class][:superclass][:superclass][:methods][:equal?]
# => "...equal?..."
