FROM amazonlinux:latest

RUN yum install -y \
cronie \
php-fpm \
procps \
which \
nano
# Copy hello-cron file to the cron.d directory
COPY testing /etc/cron.d/testing

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/testing

# Apply cron job
# RUN testing /etc/cron.d/testing
# RUN sed -i -e 's/127.0.0.1:\?//' /etc/php-fpm.d/www.conf
RUN sed -i \
    -e 's/^error_log =.*/error_log = \/dev\/stderr/' \
    -e 's/\[error_log\] =.*/[error_log] = \/dev\/stderr/' \
    -e 's/^listen =.*/listen = 0.0.0.0:9000/' \
    -e 's/^listen.allowed_clients =.*/;listen.allowed_clients = /' \
    -e 's/^;catch/catch/' \
    /etc/php-fpm.conf /etc/php-fpm.d/*

RUN echo "access.log = /dev/stdout" >> /etc/php-fpm.d/www.conf
RUN echo "clear_env = no" >> /etc/php-fpm.d/www.conf

RUN sed -i '/session.*required.*pam_loginuid.so/c\#session    required   pam_loginuid.so' /etc/pam.d/crond
# Create the log file to be able to run tail
RUN touch /var/log/cron.log

#RUN touch /tmp/data/test.txt
#RUN chown apache /tmp/data/test.txt

#RUN useradd php -u 7001
RUN usermod -s /bin/bash apache

# Run the command on container startup
#CMD ["cron", "-f", "-L", "15"]
CMD /usr/sbin/crond -n -s
#CMD /usr/sbin/crond -n -s && tail -f /var/log/cron.log
