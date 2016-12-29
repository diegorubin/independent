FROM fedora:25
MAINTAINER rubin.diego@gmail.com

# dependences
RUN dnf -y install ruby ruby-devel make gcc redhat-rpm-config \
  ImageMagick-devel libxml2-devel libxslt-devel nodejs tar
RUN gem install bundler

# make directories
RUN mkdir /application
RUN mkdir /application/kindle
RUN mkdir /application/log
WORKDIR /application

# dependences for preview websocket server
ADD package.json /application/package.json
RUN npm install

# install gems
ADD Gemfile /application/Gemfile
ADD Gemfile.lock /application/Gemfile.lock
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install --without development test

# install kindlerb
RUN bundle binstubs kindlerb --force
RUN bin/setupkindlerb

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

