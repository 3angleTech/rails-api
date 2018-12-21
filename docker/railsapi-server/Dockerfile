FROM ruby:2.5.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get update -qq && apt-get install -y xvfb libfontconfig wkhtmltopdf

ENV RAILS_ENV=production
#ENV RAILSAPI_DATABASE_PASSWORD=
ENV RAILSAPI_DATABASE_HOST=3at-railsapi-postgres

COPY ./ ./app

COPY ./docker/railsapi-server/start-server.sh /
RUN chmod +x start-server.sh

COPY ./docker/railsapi-server/lib/wait-for-it/wait-for-it.sh /

CMD ["/wait-for-it.sh", "3at-railsapi-postgres:5432", "--", "/start-server.sh"]
