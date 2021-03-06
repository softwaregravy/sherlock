[![Circle CI](https://circleci.com/gh/segmentio/sherlock.svg?style=svg&circle-token=549661cd6c45d67690129d9737a0402f31cb1657)](https://circleci.com/gh/segmentio/sherlock)

# Sherlock

> Used to scrape a web page to detect what 3rd-party services are being used.
> Check out [sherlock-segment](https://github.com/segmentio/sherlock-segment)
> for a collection of plugin examples.

## Example

```js
var sherlock = require('sherlock-inspector');

// add plugins to support various services
var segment = require('sherlock-segment');

// even custom ones you define yourself!
var myTracker = {
  name: 'myTracker',
  script: /http(s)?:\/\/(.)\.myTracker\.com/,
  settings: function () {
    return window.myTracker.id;
  }
};

sherlock()
  .use(segment)
  .use(myTracker)
  .analyze('segment.com', function (err, results) {
    console.log(results); // { id: 'abc123' }
  });
```


## How It Works

Sherlock performs the following steps during it's analysis:

 1. Opens a `url` using [Nightmare](http://www.nightmarejs.org/)
 2. Iterates through configured services looking for `<script>` tags matching
    the `service.script` option
 3. For each service found, the `service.settings` function is invoked on the
    page to extract the service's configuration (such as an API key)


## API

### sherlock()

Creates a new instance of sherlock. (can also be used as a constructor)

### sherlock.use(plugin)

Adds a `plugin` to the sherlock instance. It can either be a single service
configuration object or an array of configuration objects.

### sherlock.analyze(url, callback)

Opens the given `url` and extracts information about the configured services.

The `callback` is invoked with `err` and `results`. `results` is an object,
where each property is `service.name` and the value is the data extracted by
the `service.settings` function.


## Plugins (Services)

Sherlock is meant to scrape a web page and detect the services it is using. By
using a plugin architecture, this allows developers to publish their own lists
of services. (without requiring internal tight-coupling)

A plugin simply exports an array of objects. Each object configures a single
service, and supports the following properties:

### name

Used as the key in the results object. (must be a `String`)

### script

Used to detect support for a service amongst the `<script>` tags on the page.
The `src` attribute is matched using the following rules:

When a `String`, it will look for an exact match.

When a `RegExp`, it will perform a regular expression test.

When a `Function`, it will be invoked with the `src` as the only argument, and
if a truthy value is returned, it is assumed to be a match.

### settings (optional)

A `Function` that is invoked on the page itself, whatever value it returns is
assumed to be the settings for the given service.

If the function throws an error or returns a falsy value, retry up to 5 times
in 500ms intervals.

When excluded, the results object will be populated with `true` by default.


## Publishing a Plugin

When publishing your plugin, use the following conventions in your
`package.json` to make it easy for others to find:

 * `name` use "sherlock-" as a prefix
 * `keywords` should include "sherlock"

Once it is published, we can list it right here:

 * [Segment](http://github.com/segmentio/sherlock-segment)


## PhantomJS

You will **need** to install [PhantomJS](http://phantomjs.org/) separately.

**NOTE:** You will currently need to rely on PhantomJS v1, as v2 is unsupported.
(see #23)

```sh
$ sudo npm -g install phantomjs@1
```
