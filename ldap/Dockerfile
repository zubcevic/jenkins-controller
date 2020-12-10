FROM osixia/openldap
LABEL maintainer="rene@zubcevic.com"
ENV LDAP_ORGANISATION="Zubcevic.com IT consultancy and engineering" 
ENV LDAP_DOMAIN="zubcevic.com"
COPY bootstrap.ldif /container/service/slapd/assets/config/bootstrap/ldif/50-bootstrap.ldif
