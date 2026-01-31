{
  self,
  ...
}:
{
  age = {
    secrets = {
      tailscale.file = ../secrets/tailscale.age;
      poaclu = {
        file = ../secrets/poaclu.age;
        #mode = "0440";
        #owner = "poaclu";
        #group = "poaclu";
      };
      root = {
        file = ../secrets/root.age;
        mode = "0440";
        owner = "root";
        group = "root";
      };
      gh_token = {
        file = ../secrets/gh_token.age;
        mode = "0440";
        owner = "root";
        group = "root";
      };
    };
    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/home/poaclu/.ssh/id_ed25519_agenix"
    ];
  };
}
