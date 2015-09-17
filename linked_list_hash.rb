node1 = {
  next_node: nil,
  data: {
    :equal? => "...equal?..."
  },
}

node2 = {
  next_node: node1,
  data: {
    to_s: "...to_s..."
  },
}

node3 = {
  next_node: node2,
  data:  {
    birthday: "@age += 1"
  },
}

list = {
  head: node3,

}

list[:head][:next_node][:next_node][:data][:equal?]
# => "...equal?..."
