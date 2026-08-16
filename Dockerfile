FROM ruby:3.2.5
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN apt-get update -qq \
&& apt-get install -y ca-certificates curl gnupg \
&& mkdir -p /etc/apt/keyrings \
&& curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
&& NODE_MAJOR=19 \
&& wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update -qq \
&& apt-get install -y build-essential libpq-dev nodejs yarn

WORKDIR /wishlist_app

COPY Gemfile /wishlist_app/Gemfile
COPY Gemfile.lock /wishlist_app/Gemfile.lock
# ❌ COPY yarn.lock ... の行を削除しました

RUN bundle install
# ❌ RUN yarn install の行を削除しました

COPY . /wishlist_app