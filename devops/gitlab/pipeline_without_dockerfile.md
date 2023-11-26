# Gitlab CI for running Ruby on Rails code (without Dockerfile)

Below example will cache bundle install result to it wont install in both test example. Both tests have same repeated `before_script` check example below to not repeat `before_script`

```yml
stages:
  - validate
  - test

variables:
  RAILS_ENV: test
  POSTGRES_DB: devops_practice_test
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: password
  DATABASE_URL: "postgres://postgres:password@postgres/devops_practice_test"

cache:
  key: ${CI_COMMIT_SHA}
  paths:
    - vendor/ruby

run_rubocop:
  stage: validate
  image: ruby:3.2.2
  before_script:
    - apt-get update -qq && apt-get install -y nodejs libpq-dev
    - bundle config set --local path 'vendor/ruby'
    - bundle install
    - bundle exec rails db:create
    - bundle exec rails db:migrate
  script:
    - bundle config set --local path 'vendor/ruby'
    - bundle install
    - bundle exec rubocop
  services:
  - postgres:16.1

rspec_test:
  stage: test
  image: ruby:3.2.2
  before_script:
    - apt-get update -qq && apt-get install -y nodejs libpq-dev
    - bundle config set --local path 'vendor/ruby'
    - bundle install
    - bundle exec rails db:create
    - bundle exec rails db:migrate
    - bundle exec rails db:test:prepare
  script:
    - bundle exec rspec
  services:
  - postgres:16.1

minitest_test:
  stage: test
  image: ruby:3.2.2
  before_script:
    - apt-get update -qq && apt-get install -y nodejs libpq-dev
    - bundle config set --local path 'vendor/ruby'
    - bundle install
    - bundle exec rails db:create
    - bundle exec rails db:migrate
  script:
    - bundle exec rake test
  services:
    - postgres:16.1
```

NOTE: for Rubocop to work properly in Gitlab, you need to add the following

```yml
inherit_mode:
  merge:
    - Exclude
```

## Same example but by using shared before_script

```yml
stages:
  - validate
  - test

variables:
  RAILS_ENV: test
  POSTGRES_DB: devops_practice_test
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: password
  DATABASE_URL: "postgres://postgres:password@postgres/devops_practice_test"

cache:
  key: ${CI_COMMIT_SHA}
  paths:
    - vendor/ruby

.default_before_scripts: &default_before_scripts
  - apt-get update -qq && apt-get install -y nodejs libpq-dev
  - bundle config set --local path 'vendor/ruby'
  - bundle install
  - bundle exec rails db:create
  - bundle exec rails db:migrate
  - bundle exec rails db:test:prepare

rubocop:
  stage: validate
  image: ruby:3.2.2
  before_script:
    *default_before_scripts
  script:
    - bundle exec rubocop
  services:
  - postgres:16.1

rspec:
  stage: test
  image: ruby:3.2.2
  before_script:
    *default_before_scripts
  script:
    - bundle exec rspec
  services:
  - postgres:16.1

minitest:
  stage: test
  image: ruby:3.2.2
  before_script:
    *default_before_scripts
  script:
    - bundle exec rake test
  services:
    - postgres:16.1
```