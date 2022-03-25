FROM ruby:3.1.1

ENV APP /app
RUN mkdir -p $APP && \
    sh -c 'wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update -y && \
    apt-get install default-mysql-client google-chrome-stable nodejs npm vim graphviz -y && \
    npm uninstall yarn -g && \
    npm install yarn -g -y

COPY . $APP/

WORKDIR $APP

RUN bundle install -j4
