//just has a hanging http request that it can be told to return on whenever


import 'dart:io';

class StatusQuery {
    HttpRequest request;
    StatusQuery(HttpRequest this.request);

    void close() {
        request.response.write("YES!");
        request.response.close();
    }

}