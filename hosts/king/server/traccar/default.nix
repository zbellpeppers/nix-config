{ config, ... }:
{
  # Secret for below
  age.secrets = {
    traccar-env-file = {
      file = ../../../../secrets/traccar-env.age;
    };
  };
  services.traccar = {
    # The contents of this file should be:
    # DB_PASSWORD=PASSWORD
    # TRACCAR_SMTP_TOKEN=TOKEN
    # LOCATIONIQ_TOKEN=TOKEN
    # TRACCAR_BACKUP_TOKEN=TOKEN
    environmentFile = config.age.secrets.traccar-env-file.path;
    enable = true;
    settings = {
      # Database settings
      databaseUser = "traccar";
      databaseDriver = "com.mysql.cj.jdbc.Driver";
      databaseUrl = "jdbc:mysql://localhost/traccar?zeroDateTimeBehavior=round&amp;serverTimezone=America/New_York&amp;allowPublicKeyRetrieval=true&amp;useSSL=false&amp;allowMultiQueries=true&amp;autoReconnect=true&amp;useUnicode=yes&amp;characterEncoding=UTF-8&amp;sessionVariables=sql_mode=''";
      databasePassword = "$DB_PASSWORD";
      # Protocol settings
      protocolsEnable = "osmand";
      osmandPort = "5055";
      # Web settings
      webAddress = "127.0.0.1";
      webPort = "8082";
      webUrl = "https://traccar.bell-peppers.com";
      serverTimeout = "600";
      # Smtp settings
      mailSmtpHost = "smtp-relay.proton.me";
      mailSmtpPort = "587";
      mailSmtpFrom = "zachary@bell-peppers.com";
      mailSmtpUsername = "zachary@bell-peppers.com";
      mailSmtpPassword = "$TRACCAR_SMTP_TOKEN";
      mailSmtpStarttlsEnable = "true";
      # Filter settings
      filterEnable = "true";
      filterInvalid = "true";
      filterZero = "true";
      filterDuplicate = "true";
      filterOutdated = "true";
      filterFuture = "86400L";
      filterAccuracy = "50";
      # Geocoder settings
      geocoderEnable = "true";
      geocoderType = "locationiq";
      geocoderKey = "$LOCATIONIQ_TOKEN";
      geocoderOnrequest = "true";
      # Backup account token
      webServiceaccounttoken = "$TRACCAR_BACKUP_TOKEN";
    };
  };
}
