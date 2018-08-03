'use strict';

var VERSION = require('./package.json').version;

var path = require('path');

module.exports =
  process.platform === 'linux' && process.arch === 'x64'
    ? path.join(__dirname, 'sedlex-ppx-v' + VERSION + '-linux-x64', 'ppx.exe') :
  process.platform === 'darwin' && process.arch === 'x64'
    ? path.join(__dirname, 'sedlex-ppx-v' + VERSION + '-darwin-x64', 'ppx.exe') :
  // process.platform === 'win32' &&  process.arch === 'x64'
  //   ? path.join(__dirname, 'sedlex-ppx-v' + VERSION, 'ppx.exe') :
  null;
