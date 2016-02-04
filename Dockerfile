FROM base/archlinux

COPY arangodb-pkg.tar.xz /arangodb-pkg.tar.xz
RUN yes | pacman -Sy archlinux-keyring && \
    pacman -Sy --noconfirm &&\ 
    pacman -S pacman --noconfirm &&\
    pacman-db-upgrade &&\
    yes | pacman -Syu && \
    yes | pacman -U /arangodb-pkg.tar.xz && \
    sed -ri \
# https://docs.arangodb.com/ConfigureArango/Arangod.html
        -e 's!127\.0\.0\.1!0.0.0.0!g' \
# https://docs.arangodb.com/ConfigureArango/Logging.html
        -e 's!^(file\s*=).*!\1 -!' \
        /etc/arangodb/arangod.conf

VOLUME ["/var/lib/arangodb", "/var/lib/arangodb-apps"]

EXPOSE 8529
CMD ["/usr/sbin/arangod"]
