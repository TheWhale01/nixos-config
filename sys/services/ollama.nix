{ pkgs,... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
  };
  services.searx = {
    enable = true;
    package = pkgs.searxng;
    settings = {
      server = {
        port = 8082;
        bind_address = "127.0.0.1";
        secret_key = "f7ed3977978c46ade8afa2eb837c95e58f398c74c49f50c57bb9c02be643a50d";
      };
      search = {
        formats = [ "html" "json" ];
      };
      outgoing = {
        request_timeout = 5.0;
        max_request_timeout = 15.0;
        pool_connections = 100;
        pool_maxsize = 20;
        enable_http2 = true;
      };
      engines = [
        { name = "google"; disabled = false; }
        { name = "bing"; disabled = false; }
        { name = "brave"; disabled = false; }
        { name = "wikipedia"; disabled = false; }
      ];
    };
  };
}
