{
  self,
  ...
}:
{
  age = {
    secrets = {
      tailscale.file = "${self.inputs.secrets}/tailscale.age";
      poaclu = {
        file = "${self.inputs.secrets}/poaclu.age";
        #mode = "0440";
        #owner = "poaclu";
        #group = "poaclu";
      };
      root = {
        file = "${self.inputs.secrets}/root.age";
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
