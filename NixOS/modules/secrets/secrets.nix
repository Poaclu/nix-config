let 
  coruscant = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAvcktUBdEv3ytfb1LLV8Otxtqbk79R4rq/OQA8X5kwD";
  killi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFu8YL+1h2B++nGS7EKKRbeinDKP9XdQoIsArl7yQQKr";
  kermel = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMw+q7CMfNzK/7jCrHw2PolYdsYAr7Axl94XWuH+B8cV";
  odonata = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINymnGddDA5zNXdG1j0ob5vXyHvPyXNsfZM55zIFUacX";
  systems = [ coruscant killi kermel odonata ];

  kermel-tailscale = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMxK7XnAVV3jMeW92aneitlabVE1jx1LjnHBvn5IbNFx";
  tailscale = [ kermel-tailscale ];
  
  poaclu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOx1bYl4wDmzgdF5lrSxRONdASSo5A7skP23jNYQ5sQw";
  poaclu2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII64QLrtKBoEwq7w/NaWYTpAPxHEsUgTs2MaDnw7qpHz";
  users = [ poaclu poaclu2 ];
in 
{
  "tailscale.age".publicKeys = systems ++ users ++ tailscale;
  "poaclu.age".publicKeys = systems ++ users ++ tailscale;
  "root.age".publicKeys = systems ++ users ++ tailscale;
  "gh_token.age".publicKeys = systems ++ users ++ tailscale;
}
