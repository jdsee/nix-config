{ ... }:
{
  systemd.services.resticBackup = {
    description = "Backup the user directory to Storage Box via restic";
    startAt = "weekly";
    script = /*bash*/''
      restic \
      --tag jdsee-user \
      -q \
      -r sftp://backupbox/home/restic-repo \
      backup /home/jdsee \
      -e 'Downloads' \
      -e '*.log'
      '';
    serviceConfig = {
      User = "jdsee";
    };
  };
}
