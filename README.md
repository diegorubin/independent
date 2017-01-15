Independent CMS Blog
====================

[![Code Climate](https://codeclimate.com/github/diegorubin/independent.png)](https://codeclimate.com/github/diegorubin/independent) [![Build Status](https://travis-ci.org/diegorubin/independent.svg)](https://travis-ci.org/diegorubin/independent) [![Coverage Status](https://coveralls.io/repos/diegorubin/independent/badge.png?branch=master)](https://coveralls.io/r/diegorubin/independent?branch=master)[![Stories in Ready](https://badge.waffle.io/diegorubin/independent.svg?label=ready&title=Ready)](http://waffle.io/diegorubin/independent)[![Stories in In Progress](https://badge.waffle.io/diegorubin/independent.svg?label=in progress&title=In Progress)](http://waffle.io/diegorubin/independent)

## Usage With Docker

The image can be found in [Docker Hub](https://hub.docker.com/r/diegorubin/independent/) as `diegorubin/independent`.

### Volumes

| Container Path              | Description                                         |
| --------------------------- | --------------------------------------------------- |
| /application/public/uploads | public uploads (images to presentations and slides) |
| /application/kindle         | generated posts kindle files                        |
| /application/themes         | themes' files                                       |
| /application/uploads        | private uploads (themes and assets)                 |

### Environment Settings

To change settings use variables of environments.
The settings avaibles are:

| Variable Name                            | Description                                | Default Value   |
| ---------------------------------------- | ------------------------------------------ | --------------- |
| DEVISE\_SECRET\_KEY                      | hash used to devise lib                    |                 |
| INDEPENDENT\_PORT                        | port used to access application            |                 |
| INDEPENDENT\_MONGODB\_DATABASE           | name of database                           | independent     |
| INDEPENDENT\_MONGODB\_USERNAME           | database username                          |                 |
| INDEPENDENT\_MONGODB\_PASSWORD           | database password                          |                 |
| INDEPENDENT\_MONGODB\_HOST               | mongodb host with port                     | localhost:27017 |
| MAILER\_ADDRESS                          | smtp host address                          |                 |
| MAILER\_AUTHENTICATION                   | authentication form                        | plain           |
| MAILER\_DOMAIN                           | domain of email contact                    |                 |
| MAILER\_ENABLE\_STARTTLS\_AUTO           | enable tls                                 | false           |
| MAILER\_PORT                             | smtp email port                            |                 |
| MAILER\_USER\_NAME                       | smtp username                              |                 |
| MAILER\_PASSWORD                         | password for smtp account                  |                 |
| NEWRELIC\_APP\_NAME                      | newrelic app name (optional)               |                 |
| NEWRELIC\_LICENSE\_KEY                   | newrelic license key (optional)            |                 |
| PREVIEW\_HOST                            | host to access web socket for preview app  |                 |
| PREVIEW\_WS\_PORT                        | port to access web socket for preview app  |                 |
| RAILS\_ENV                               | rails environment                          | development     |
| SECRET\_KEY\_BASE                        | hash to generate sessions                  |                 |

