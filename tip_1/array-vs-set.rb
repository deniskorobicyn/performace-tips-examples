require 'benchmark/ips'
require 'set'
require 'pry'


def search(data, base)
  data.each do|word|
    base.include?(word)
  end
end

result_set = []
result_array = []

max_size = ENV.fetch('SIZE', 1).to_i
step = ENV.fetch('STEP', 1).to_i

sizes = (1..max_size).step(step).to_a

sizes.each do |size|
  base = (1..(10 * size)).to_a

  base_set = Set.new(base)

  data = (1..(3 * size)).to_a 

  res = Benchmark.ips do |x|
    x.report('set iteration') {  search(data, base_set) }
    x.report('array iteration') { search(data, base) }
  end

  result_array << res.entries.last.stats.central_tendency
  result_set << res.entries.first.stats.central_tendency
end

p result_array
p result_set