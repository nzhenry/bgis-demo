var assert = require('assert');

describe('page title', function() {
  it('has the correct page title', function() {
    return browser
      .url('/')
      .getTitle()
      .then(function(title) {
        assert.equal(title, 'End-to-End Testing');
      });
  });
});