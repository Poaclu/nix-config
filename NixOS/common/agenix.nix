{
  inputs,
  ...
}:
{
  age = {
    secrets = {
      tailscale.file = "${inputs.secrets}/tailscale.age";
      poaclu = {
        file = "${inputs.secrets}/poaclu.age";
        #mode = "0440";
        #owner = "poaclu";
        #group = "poaclu";
      };
      root = {
        file = "${inputs.secrets}/root.age";
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
