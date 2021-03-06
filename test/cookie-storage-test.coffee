assert = require 'power-assert'
{CookieStorage} = require '../dist/cookie-storage'

describe 'CookieStorage', ->
  beforeEach ->
    @storage = new CookieStorage()
    global.document = {}

  afterEach ->
    delete global.document

  describe '#constructor', ->
    it 'works', ->
      @storage = new CookieStorage(path: '/')
      @storage.setItem 'b', '2'
      assert document.cookie is 'b=2;path=/'
      @storage = new CookieStorage(domain: 'example.com')
      @storage.setItem 'c', '3'
      assert document.cookie is 'c=3;domain=example.com'
      @storage = new CookieStorage(expires: new Date(1427005235068))
      @storage.setItem 'd', '4'
      assert document.cookie is 'd=4;expires=Sun, 22 Mar 2015 06:20:35 GMT'
      @storage = new CookieStorage(secure: true)
      @storage.setItem 'e', '5'
      assert document.cookie is 'e=5;secure'

  describe '#length', ->
    it 'should be 0', ->
      assert @storage.length is 0

    it 'works', ->
      document.cookie = 'a=1'
      assert @storage.length is 1
      document.cookie = 'a=1;b=2'
      assert @storage.length is 2

  describe '#key', ->
    beforeEach ->
      document.cookie = 'a=1;b=2'

    it 'should be a function', ->
      assert typeof @storage.key is 'function'

    it 'works', ->
      assert @storage.key(0) is 'a'
      assert @storage.key(1) is 'b'

  describe '#getItem', ->
    beforeEach ->
      document.cookie = 'a=1;b=2'

    it 'should be a function', ->
      assert typeof @storage.getItem is 'function'

    it 'works', ->
      assert @storage.getItem('a') is '1'
      assert @storage.getItem('b') is '2'

  describe '#setItem', ->
    it 'should be a function', ->
      assert typeof @storage.setItem is 'function'

    it 'works', ->
      @storage.setItem 'a', '1'
      assert document.cookie is 'a=1'
      @storage.setItem 'b', '2', path: '/'
      assert document.cookie is 'b=2;path=/'
      @storage.setItem 'c', '3', domain: 'example.com'
      assert document.cookie is 'c=3;domain=example.com'
      @storage.setItem 'd', '4', expires: new Date(1427005235068)
      assert document.cookie is 'd=4;expires=Sun, 22 Mar 2015 06:20:35 GMT'
      @storage.setItem 'e', '5', secure: true
      assert document.cookie is 'e=5;secure'

  describe '#removeItem', ->
    it 'should be a function', ->
      assert typeof @storage.removeItem is 'function'

    it 'works', ->
      @storage.removeItem 'a'
      assert document.cookie is 'a=;expires=Thu, 01 Jan 1970 00:00:00 GMT'

  describe '#clear', ->
    it 'should be a function', ->
      assert typeof @storage.clear is 'function'

    it 'works', ->
      document.cookie = 'a=1'
      @storage.clear()
      assert document.cookie is 'a=;expires=Thu, 01 Jan 1970 00:00:00 GMT'
