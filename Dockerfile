FROM wordpress:apache

RUN apt-get -qq update && \ 
	apt-get -y install msmtp msmtp-mta && \
	rm /var/lib/apt/lists/* -rf && \
	echo "sendmail_path=sendmail -i -t" > /usr/local/etc/php/conf.d/php-sendmail.ini

COPY msmtprc /etc/msmtprc.in
COPY docker-php-configure-smtp-entrypoint /usr/local/bin/docker-php-configure-smtp-entrypoint

RUN echo "upload_max_filesize = 64M\npost_max_size = 64M\nmemory_limit = 256M" > /usr/local/etc/php/conf.d/php-filesize.ini

CMD [ "docker-php-configure-smtp-entrypoint" ]

