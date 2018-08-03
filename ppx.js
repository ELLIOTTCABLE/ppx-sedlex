#!/usr/bin/env node

'use strict';
var spawn = require('child_process').spawn;

var bin = require('./');
var input = process.argv.slice(2);
input.unshift('--as-ppx');

if (bin !== null) {
  spawn(bin, input, {stdio: 'inherit'})
    .on('exit', process.exit);
} else {
  throw new Error('Platform not supported.');
}
