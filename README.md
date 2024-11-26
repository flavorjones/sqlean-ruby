# SQLean Ruby

Precompiled [SQLean](https://github.com/nalgeon/sqlean) extensions for SQLite, packaged for the Ruby ecosystem. Compatible with SQLite3, Extralite, and any other sqlite-based library that exposes [`sqlite3_load_extension`](https://www.sqlite.org/c3ref/load_extension.html).


## Usage

Please read the upstream documentation at https://antonz.org/sqlean/ or https://github.com/nalgeon/sqlean for details on what is provided by the SQLean extensions.

The available extensions are:

- [SQLean::Crypto](https://github.com/nalgeon/sqlean/blob/main/docs/crypto.md): Hashing, encoding and decoding data
- [SQLean::Define](https://github.com/nalgeon/sqlean/blob/main/docs/define.md): User-defined functions and dynamic SQL
- [SQLean::FileIO](https://github.com/nalgeon/sqlean/blob/main/docs/fileio.md): Reading and writing files
- [SQLean::Fuzzy](https://github.com/nalgeon/sqlean/blob/main/docs/fuzzy.md): Fuzzy string matching and phonetics
- [SQLean::IPAddr](https://github.com/nalgeon/sqlean/blob/main/docs/ipaddr.md): IP address manipulation (not supported on Windows)
- [SQLean::Math](https://github.com/nalgeon/sqlean/blob/main/docs/math.md): Math functions
- [SQLean::Regexp](https://github.com/nalgeon/sqlean/blob/main/docs/regexp.md): Regular expressions
- [SQLean::Stats](https://github.com/nalgeon/sqlean/blob/main/docs/stats.md): Math statistics
- [SQLean::Text](https://github.com/nalgeon/sqlean/blob/main/docs/text.md): String functions
- [SQLean::Unicode](https://github.com/nalgeon/sqlean/blob/main/docs/unicode.md): Unicode support
- [SQLean::UUID](https://github.com/nalgeon/sqlean/blob/main/docs/uuid.md): Universally Unique IDentifiers
- [SQLean::VSV](https://github.com/nalgeon/sqlean/blob/main/docs/vsv.md): CSV files as virtual tables


### with SQLite3

Extend a SQLite3 database with SQLean extensions:

``` ruby
require "sqlite3"
require "sqlean"

db = SQLite3::Database.new("path/to/db.sqlite")
db.enable_load_extension(true)

db.load_extension(SQLean.to_path) # load every extension in SQLean
db.load_extension(SQLean::Crypto.to_path) # or load individual extensions
```

<!-- not available yet!
or, if using sqlite3 gem >= 2.4.0:

```
db.load_extension(SQLean) # load every extension in SQLean
db.load_extension(SQLean::Crypto) # or load individual extensions
```
-->

<!-- also not available yet!
### with SQLite3 in Rails

When using SQLite3 v2.4.0+ and Rails 8.1.0+:

``` yaml
# config/database.yml

development:
  adapter: sqlite3
  extensions:
    - SQLean # load every extension in SQLean
    - SQLean::Crypto # or load individual extensions
```
-->

### with Extralite

Extend an Extralite database with SQLean extensions:

``` ruby
require "extralite"
require "sqlean"

db = Extralite::Database.new("path/to/db.sqlite")

db.load_extension(SQLean.to_path) # load every extension in SQLean
db.load_extension(SQLean::Crypto.to_path) # or load individual extensions
```


## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add sqlean
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install sqlean
```

Note that right now, the only platforms supported are:

- MacOS / Darwin:
  - x86_64
  - arm64
- Linux
  - x86_64 gnu
  - x86_64 musl
  - aarch64 gnu
- Windows
  - mingw (64-bit)

Specifically what's missing is support for:

- Linux aarch64 musl
- Windows mingw32 (32-bit)

If you need support for one of these platforms, please open an issue. I would also gladly welcome folks who are willing to help add support.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/flavorjones/sqlean-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/flavorjones/sqlean-ruby/blob/main/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## Code of Conduct

Everyone interacting in the sqlean-ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/flavorjones/sqlean-ruby/blob/main/CODE_OF_CONDUCT.md).
