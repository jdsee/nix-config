{ user ? "jdsee" #TODO: Remove default user
, ...
}:
{
  virtualisation.virtualbox = {
    host = {
      enable = false;
      enableExtensionPack = true;
    };
  };

  users.extraGroups.vboxusers.members = [
    "jdsee"
  ];
}
