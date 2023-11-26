
# CI examle using Dockerfile rather than setting up directly in Gitlab

```yml
stages:
  - build
  - validate
  - test

variables:
  RAILS_ENV: test
  POSTGRES_DB: devops_practice_test
  POSTGRES_USER: postgres
  POSTGRES_PASSWORD: password
  DATABASE_URL: "postgres://postgres:password@postgres/devops_practice_test"
  IMAGE_TAG: $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG

.default_before_scripts: &default_before_scripts
  - bundle exec rails db:create
  - bundle exec rails db:migrate
  - bundle exec rails db:test:prepare

build:
  image: docker:20.10.16
  stage: build
  services:
    - docker:20.10.16-dind
  script:
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
    - docker build -t $IMAGE_TAG . -f Dockerfile.ci
    - docker push $IMAGE_TAG

rubocop:
  stage: validate
  image: $IMAGE_TAG
  before_script:
    *default_before_scripts
  script:
    - bundle exec rubocop
  services:
  - postgres:16.1

rspec:
  stage: test
  image: $IMAGE_TAG
  before_script:
    *default_before_scripts
  script:
    - bundle exec rspec
  services:
  - postgres:16.1

minitest:
  stage: test
  image: $IMAGE_TAG
  before_script:
    *default_before_scripts
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