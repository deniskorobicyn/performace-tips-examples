const Benchmark = require('benchmark');

function rand(max) {
  return Math.floor(Math.random() * Math.floor(max));
}

function generateArray(max) {
  let array = [];
  for(let i = 0; i < max; ++i) {
    const number = rand(max);
    array.push(number);
  }
  return array;
}

max = process.env.MAX

  const arr = generateArray(max);
  const set = new Set([...arr]);

  const suite = new Benchmark.Suite(max);
  suite.add('array', function() {
    arr.includes(rand(max));
    return 1;
  })
  .add('set', function() {
    set.has(rand(max));
    return 1;
  })
  .on('cycle', function(event) {
    console.log(String(event.target));
  })
  .on('complete', function() {
    console.log('Fastest is ' + this.filter('fastest').map('name'));
  })
  .run({ 'async': false });
