#Each Method

def each_2(array, &block)
  for e in 0..array.length
    block.call(array[e])
  end
end

array = [1, 2, 3, 4, 5]

array.each {|e| puts e}

each_2(array) {|e| puts e}

