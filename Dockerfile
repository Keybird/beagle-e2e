FROM vegansk/ubuntu-java-nodejs

# Debian package configuration use the noninteractive frontend:
# It never interacts with the user at all, and makes the default answers be used for all questions.
# http://manpages.ubuntu.com/manpages/wily/man7/debconf.7.html
ENV DEBIAN_FRONTEND noninteractive

# Install Convenient stuff
RUN apt update \
    && apt install -y curl wget

# Install google chrome
RUN  apt update \
        && apt install -y libxss1 libappindicator1 libindicator7 fonts-liberation xdg-utils gconf-service libgconf-2-4 \
        && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
        && dpkg -i google-chrome*.deb

# Fix chromedriver issue.
# "error while loading shared libraries: libgconf-2.so.4: cannot open shared object file: No such file or directory"
# See https://stackoverflow.com/questions/22924339/chromedriver-on-ubuntu-12-04-error-while-loading-shared-libraries-libxi-so-6
RUN apt update \
    && apt install -y libxi6 libgconf-2-4

# Install Protractor
RUN npm install -g protractor@5.2.2

# Update webdriver
RUN webdriver-manager update

# Clean up afterwards
RUN apt autoclean -y && apt clean

WORKDIR /protractor/
ENV HOME=/protractor/project

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]