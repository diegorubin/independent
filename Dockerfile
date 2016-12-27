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
WORKDIR /application

# install gems
ADD Gemfile /application/Gemfile
ADD Gemfile.lock /application/Gemfile.lock
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --without development test

# copy config files
ADD config.ru /application/config.ru
ADD Rakefile /application/Rakefile

# copy directories
ADD bin /application/bin
ADD public /application/public
ADD widgets /application/widgets
ADD lib /application/lib
ADD config /application/config
ADD app /application/app

CMD bin/independent

EXPOSE 9292

