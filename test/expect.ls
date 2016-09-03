require! {
  chai
}

map-to-obj = (map) ->
  obj = Object.create null

  for [key, value] in Array.from map.entries!
    obj[key] = value

  obj

chai.use ({Assertion}, util) ->
  Assertion.add-method 'map' (expected) ->
    new Assertion @_obj .to.be.instanceof Map

    actual-obj = map-to-obj @_obj

    expected-obj =
      if expected instanceof Map
        map-to-obj expected
      else
        expected

    new Assertion actual-obj .to.deep.equal expected-obj

module.exports = chai.expect
