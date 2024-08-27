######################################################################################
######################################################################################

#
# ##################
# DNSMASQ DOCKERFILE
# ##################
#

#
# SOURCES ...
#
#  > https://www.howtoforge.com/how-to-set-up-local-dns-with-dnsmasq-on-debian-12/
#

######################################################################################
######################################################################################

#
# ######################################################
# PULL BASE IMAGE (https://hub.docker.com/_/debian/tags)
# ######################################################
#

FROM debian:bookworm

#
# ###############
# BUILD ARGUMENTS
# ###############
#

ARG CI_COMMIT_TAG="0000000000"

#
# #################
# IMAGE INFORMATION
# #################
#

ENV DNSMASQ_IMAGE_MAINTAINER="Norbert EHART (norbert@ehart.net)"

ENV DNSMASQ_VERSION="2.89"
ENV DNSMASQ_BUILD_DATE="${CI_COMMIT_TAG}"

#
# #############################
# DEFAULT ENVIRONMENT VARIABLES
# #############################
#

ENV DEBIAN_FRONTEND="noninteractive"

ENV TERM="xterm"

ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"

#
# #################
# WORKING DIRECTORY
# #################
#

WORKDIR /

#
# ###################################
# RUN CONTAINER AS ROOT (PER DEFAULT)
# ###################################
#

USER 0:0

#
# #########
# UPDATE OS
# #########
#

RUN apt update -y
RUN apt upgrade -y

#
# ##################
# INSTALL SOME TOOLS
# ##################
#

#
# RUN apt install -y tzdata
# RUN apt install -y curl
# RUN apt install -y apt-transport-https
# RUN apt install -y ca-certificates
# RUN apt install -y gnupg2
# RUN apt install -y software-properties-common
# RUN apt install -y procps
# RUN apt install -y moreutils
#

#
# ###############
# INSTALL DNSMASQ
# ###############
#

RUN apt install -y dnsmasq=2.89-1

#
# #######
# CLEANUP
# #######
#

RUN apt -y autoremove
RUN apt -y clean

#
# ################
# ENTRYPOINT & CMD
# ################
#

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/sbin/dnsmasq", "--no-daemon"]

######################################################################################
######################################################################################