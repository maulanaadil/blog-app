### Clone the repository

```shell
git clone https://github.com/maulanaadil/blog-app.git
cd blog-app
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 3.0.2`

If not, install the right ruby version using [rvm](https://www.ruby-lang.org/en/news/2021/07/07/ruby-3-0-2-released/) (it could take a while):

```shell
rvm install 3.0.2
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler):

```shell
bundler install
```

### Initialize the database

```shell
rails db:migrate db:seed
```

## Serve

```shell
rails s
```
## Testing
Testing tool using [Rspec](https://rspec.info/):
```shell
bundle exec rspec spec
```

### Spesific testing
```shell
bundle exec rpec spec/{file_test.rb}
```
