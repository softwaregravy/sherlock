# Sherlock

[![Circle CI](https://circleci.com/gh/segmentio/sherlock.svg?style=svg&circle-token=549661cd6c45d67690129d9737a0402f31cb1657)](https://circleci.com/gh/segmentio/sherlock)

> Detect which integrations a website is using and find their API keys.

## Example

```js
var sherlock = require('sherlock');

sherlock.analyze('segment.com', function (err, results) {
  // ...
});
```

## Notes

You will **need** to install [PhantomJS](http://phantomjs.org/) separately.

If you're using Homebrew, you can do this with the following command:

```sh
$ sudo brew update && brew install phantomjs
```

You can also use npm:

```sh
$ sudo npm -g install phantomjs
```