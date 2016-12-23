FROM fedora:25
MAINTAINER rubin.diego@gmail.com

# dependences
RUN dnf -y install ruby ruby-devel make gcc redhat-rpm-config \
  ImageMagick-devel libxml2-devel libxslt-devel nodejs
RUN gem install bundler

# make directories
RUN mkdir /application
RUN mkdir /application/kindle
RUN mkdir /application/log

# copy directories
ADD app /application/app
ADD bin /application/bin
ADD config /application/config
ADD lib /application/lib
ADD public /application/public
ADD widgets /application/widgets

# copy config files
ADD config.ru /application/config.ru
ADD Gemfile /application/Gemfile
ADD Gemfile.lock /application/Gemfile.lock
ADD Rakefile /application/Rakefile

WORKDIR /application

# install gems
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --without development test

# compile assets
RUN rake assets:precompile

CMD rails server

EXPOSE 3000

