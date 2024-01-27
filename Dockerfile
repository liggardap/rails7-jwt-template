FROM ruby:3.2.2

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    nodejs \
    libcurl4-gnutls-dev \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
RUN mkdir /app/.credentials
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . ./

ARG SECRET_KEY_BASE=${SECRET_KEY_BASE}
ARG RAILS_ENV=${RAILS_ENV}
ENV RAILS_SERVE_STATIC_FILES=true

RUN RAILS_ENV=$RAILS_ENV \
    SECRET_KEY_BASE=$SECRET_KEY_BASE \
    RAILS_SERVE_STATIC_FILES=true \
    DB_ADAPTER=nulldb \
    bundle exec rails assets:precompile

EXPOSE 3000

RUN chmod +x run_service.sh
ENTRYPOINT ./run_service.sh