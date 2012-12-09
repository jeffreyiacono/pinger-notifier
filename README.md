## Why?

Let's say you host a web-app on a cloud application platform (_cough_ heroku
_cough_) and this service periodically unloads your app if there hasn't been any
visitors for a given period of time. As a result, a brave visitor will be
greeted with a terrifying `500` error page, which is no good. So how do we solve
this? Use `pinger notifier` + `cron` to ensure your app is periodically reloaded.

## Usage

    $ ./pinger-notifier.sh [email-from] [email-to] [url_1 (url_2 ... etc.)]

Script uses [pinger](https://github.com/jeffreyiacono/pinger) and assumes
it's in the PATH (see: [pinger usage](https://github.com/jeffreyiacono/pinger#usage)

## Dependencies

- [pinger](https://github.com/jeffreyiacono/pinger)
- sendmail

## Installation

First, make sure that [pinger](https://github.com/jeffreyiacono/pinger) is
installed and accessible:

    $ mkdir ~/src
    $ mkdir ~/bin
    $ git clone https://github.com/jeffreyiacono/pinger.git ~/src/pinger
    $ ln -s ~/src/pinger/pinger.sh ~/bin/pinger

Make sure that `~/bin` is in your `PATH`. If it is not, add it.

Next, make sure `sendmail` is installed.

Finally, install `pinger-notifier`:

    $ git clone https://github.com/jeffreyiacono/pinger-notifier.git ~/src/pinger-notifier
    $ ln -s ~/src/pinger-notifier/pinger-notifier.sh ~/bin/pinger-notifier

You'll now have `pinger` and `pinger-notifier` accessible from the commandline.

## Cron

To add `pinger-notifier` to cron, you need to ensure that cron knows of your
installation's location so both utilities are accessible. Often your local
`bin` will not be in cron's `PATH` by default.

To remedy this you can add a `PATH` specification to your crontab like so:

    # sample crontab
    PATH=[whatever it defaults to]:/home/your-name/bin

The above will ensure that your local `bin` is available.

To schedule a pinger notifier, you'd add something like the following to your
crontab:

    # sample crontab continued ...
    */10 * * * * pinger-notifier from@email.com to@email.com http://some-website.com

With this in place `pinger-notifier` will check _http://some-website.com_ every
10 minutes and send an email to _to@email.com_ from _from@email.com_ on a
erroneous (301s or inability to get a 200 response) runs.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2012 Jeff Iacono

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
