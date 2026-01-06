{
  inputs,
  ...
}:
{
  age.secrets = {
    tailscale.file = "${inputs.secrets}/tailscale.age";
  };
}
