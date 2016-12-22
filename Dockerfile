FROM fedora:25
MAINTAINER rubin.diego@gmail.com

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

# dependences
RUN dnf -y install ruby ruby-devel make gcc redhat-rpm-config \
  ImageMagick-devel libxml2-devel libxslt-devel
RUN gem install bundler

# install gems
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --without development test

CMD rails server

EXPOSE 3000

