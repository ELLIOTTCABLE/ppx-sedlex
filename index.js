'use strict';

var VERSION = require('./package.json').version;

var path = require('path');

module.exports =
  process.platform === 'darwin'
    ? path.join(__dirname, 'sedlex-ppx-osx-v' + VERSION, 'ppx.exe') :
  process.platform === 'linux' && process.arch === 'x64'
    ? path.join(__dirname, 'sedlex-ppx-linux64-v' + VERSION, 'ppx.exe') :
  process.platform === 'win32' &&  process.arch === 'x64'
    ? path.join(__dirname, 'sedlex-ppx-win64-v' + VERSION, 'ppx.exe') :
  null;
