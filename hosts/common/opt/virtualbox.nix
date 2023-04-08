{ user ? "jdsee" # TODO: Remove default user
, ...
}:
{
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
  };

  users.extraGroups.vboxusers.members = [
    "jdsee"
  ];
}
