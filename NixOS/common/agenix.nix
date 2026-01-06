{
  inputs,
  ...
}:
{
  age = {
    secrets = {
      tailscale.file = "${inputs.secrets}/tailscale.age";
    };
    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/home/poaclu/.ssh/id_ed25519_agenix"
    ];
  };
}
