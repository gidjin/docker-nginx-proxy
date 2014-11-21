docker-nginx-proxy
==================

Basic dockerized version of nginx what will auto generate a proxy configuration for all linked containers.

Example usage with fig to listen on port 80 of the host machine and proxy 3 linked containers. Note this is to proxy 3 different websites, not to provide proxy to the same website on multiple containers

```yaml
proxy:
  image: gidjin/nginx-proxy
  ports:
    - "80:80"
  links:
    - sitea
    - siteb
    - sitec
sitea:
  image: one
siteb:
  image: two
sitec:
  image: three
```
