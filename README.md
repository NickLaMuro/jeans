Jeans
=====

A command line based [BlueJeans][] meeting opener and address book.

This is heavily based off the project by [@kbrock][], [blue_url][].


Requirements
------------

- A ruby runtime
- The [BlueJeans](bluejeans_app) application


Installation
------------

Currently the only option available for installation is via source, however,
current plans are to add more installation options in the future.

That said, this is mostly a single script application, so the process isn't
terribly involved.


### via `source`

This will build and install `jeans` as a gem on your system for the current
version of ruby.

```console
$ git clone https://github.com/NickLaMuro/jeans.git
$ cd jeans
$ rake rubygems:install
```

Or, if you want to do it manually, you can simply copy the `jeans` executable`
into your `$PATH`.


### via `rubygems`

```console
$ gem install jeans
```

**Note:**  This is currently not available as we seem to have a squatter...

https://rubygems.org/gems/jeans

Other rubygem source locations are currently being evaluated.


Usage
-----

### Creating an address book

The "address book" is just a `.csv` file in the user's home directory called
`~/.jeans.numbers`.  You can generate it yourself, or `init` one by running:

```console
$ jeans init
```

Note:  If you already have a `~/.jeans.numbers`, this will just be a no-op.


### Adding a number

Okay... I lied above (but who am I kidding... you aren't reading this anyway...
are you?).  The format of the `~/.jeans.numbers` isn't **REALLY** a CSV, just a
comma delimited list, where each row is a variable length.  The first column
for each entry is the BlueJeans number, and everything after that is an alias.

So if you wanted to add a number manually, you could simply open up the file in
your text editor, or add a line like this:

```console
$ echo "111,test,testnumber,foreveralone" > ~/.jeans.numbers
```

There is also a `jeans` subcommand (`add`) for doing that as well:

```console
$ jeans add 111 test testnumber foreveralone
```

If this number exists in the file already, the aliases that are passed in will
be merged with the existing ones and the number will just be updated.

**NOTE:** Currently, this command doesn't handle dealing with duplicate
aliases.


### Setting up autocomplete

There is currently `bash` completion functionality available to auto-complete
or provide available options for partially written aliases.

To see how to install, you can run:

```
$ jeans contrib
```

This will also be the future home of any other similar functionality that is
available that needs to be user configured after installation.


Contributing
------------

Bug reports and pull requests are welcome on [GitHub][].


TODO
----

- [ ] Improve the `add` command (make it's usage more clear)
- [ ] Add autocomplete for other shells (zsh at least)
- [ ] Linux form of `open` support
- [ ] Add a `brew` formulae for OSX
- [ ] Non-gem based distribution on Windows (`chocolatey`?)
- [ ] Non-gem based distribution on Linux   (`rpm`, `deb`... any others?)
- [ ] Convert to `crystal-lang`? (removes `ruby` requirement)


License
-------

This project is available as open source under the [MIT License][] terms.




[@kbrock]:       https://github.com/kbrock
[GitHub]:        https://github.com/NickLaMuro/jeans
[blue_url]:      https://github.com/kbrock/blue_url
[BlueJeans]:     https://www.bluejeans.com/
[MIT License]:   https://opensource.org/licenses/MIT
[bluejeans_app]: https://www.bluejeans.com/downloads
