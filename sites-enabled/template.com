server {

    listen 80;
    server_name SERVER_NAME_IN_HERE;
    charset utf-8;

    location / {
        proxy_pass http://IP_ADDRESS_IN_HERE:PORT_IN_HERE$request_uri;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }

}
