require 'benchmark/ips'
require 'set'
require 'pry'

def concat_arr(array)
  array.inject("") { |sum, n| sum + n } 
end

def join_arr(array)
  array.join
end

generate_random_string = ->(index) do
  (0...20).map { ('a'..'z').to_a[rand(26)] }.join
end

result_concat = []
result_join = []

# max_size = ENV.fetch('SIZE', 1).to_i
# step = ENV.fetch('STEP', 1).to_i
# sizes = (1..max_size).step(step).to_a

# sizes.each do |size|
  size = 2000
  array = Array.new(size, &generate_random_string)

  res = Benchmark.ips do |x|
    x.report('concat') { concat_arr(array) }
    x.report('join') { join_arr(array) }

    x.compare!
  end

#   result_concat << res.entries.first.stats.central_tendency
#   result_join << res.entries.last.stats.central_tendency
# end

# p result_concat
# p result_join