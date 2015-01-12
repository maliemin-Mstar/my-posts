#!/bin/bash

node_modules/.bin/cleancss \
  bower_components/bootstrap/dist/css/bootstrap.min.css \
  bower_components/nprogress/nprogress.css \
  bower_components/highlightjs/styles/github.css \
  bower_components/ninja/dist/ninja.bundle.min.css \
  -o dist/airpub-dependencies.min.css \
  --s0 \
  --debug