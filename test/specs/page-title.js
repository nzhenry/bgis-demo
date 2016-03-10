var assert = require('assert');

describe('Page Title', function() {
  it('has the correct page title', function() {
    return browser
      .url('/')
      .getTitle()
      .then(function(title) {
        assert.equal(title, 'Brookfield Global Integrated Solutions North America');
      });
  });
});

describe('Main Blurb', function() {
  it('has the correct main blurb', function() {
    return browser
      .url('/')
      .getText('#main-blurb')
      .then(function(text) {
        assert.equal(text, 'Since 1992, Brookfield Global Integrated Solutions has been delivering integrated real estate management services to our clients. Brookfield Global Integrated Solutions has enjoyed significant growth by helping our customers focus on their core business and delivering on our clients’ objectives.');
      });
  });
});