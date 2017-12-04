"use strict";

exports.map = function(f) {
  var Nil = require('Data.List.Types').Nil;
  var Cons = require('Data.List.Types').Cons;

  return function(l) {
    if (l === Nil.value) {
      return l;
    } else {
      var input = l;
      var result = new Cons(f(input.value0), Nil.value);
      var output = result;

      while (input.value1 !== Nil.value) {
        input = input.value1;
        output.value1 = new Cons(f(input.value0), Nil.value);
        output = output.value1;
      }

      return result;
    }
  }
}

exports.filter = function(f) {
  var Nil = require('Data.List.Types').Nil;
  var Cons = require('Data.List.Types').Cons;

  return function(l) {
    var input = l;

    // Scan the input list until we can allocate our
    // first cons cell, or until it is exhausted.
    while(input !== Nil.value && !f(input.value0)) {
      input = input.value1;
    }

    if (input === Nil.value) {
      return input;
    } else {
      var result = new Cons(input.value0, Nil.value);
      var output = result;

      while (input.value1 !== Nil.value) {
        input = input.value1;
        var b = f(input.value0);

        if (b) {
          output.value1 = new Cons(input.value0, Nil.value);
          output = output.value1;
        }
      }

      return result;
    }
  }
}

exports.zipWith = function(f) {
  var Nil = require('Data.List.Types').Nil;
  var Cons = require('Data.List.Types').Cons;

  return function(l1) {
    return function(l2) {
      if (l1 === Nil.value) {
        return l1;
      } else if (l2 === Nil.value) {
        return l2;
      } else {
        var result = new Cons(null, null);

        var input1 = l1;
        var input2 = l2;
        var output = result;

        while (true) {
          output.value0 = f(input1.value0, input2.value0);
          output.value1 = new Cons(null, null);

          if (input1.value1 === Nil.value || input2.value1 === Nil.value) {
            break;
          }

          input1 = input1.value1;
          input2 = input2.value1;
          output = output.value1;
        }

        output.value1 = Nil.value;

        return result;
      }
    }
  }
}
