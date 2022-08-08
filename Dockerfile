FROM shlinkio/shlink:stable@sha256:7e8fff23de17b75f5e30411e716b991b44eac093608f00499be5eb84401b1730

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