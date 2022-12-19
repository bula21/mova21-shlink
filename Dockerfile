FROM shlinkio/shlink:stable@sha256:9f22adf53e8aefa866681c5b56f27877247181448c78867faa7014eacbef9614

# Install OpenSSH and set the password for root to "Docker!". In this example, "apk add" is the install instruction for an Alpine Linux-based image.
RUN apk add openssh \
     && echo "root:Docker!" | chpasswd 

# Copy the sshd_config file to the /etc/ssh/ directory
COPY docker/sshd_config /etc/ssh/

COPY docker/azure-entrypoint.sh /azure-entrypoint

# Copy and configure the ssh_setup file
RUN mkdir -p /tmp
COPY docker/ssh_setup.sh /tmp
RUN chmod +x /tmp/ssh_setup.sh \
    && (sleep 1;/tmp/ssh_setup.sh 2>&1 > /dev/null)

# Open port 2222 for SSH access
EXPOSE 8080 2222

ENTRYPOINT [ "/azure-entrypoint" ]