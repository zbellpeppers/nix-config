{ config, ... }:
{
  # Secret for below
  age.secrets = {
    traccar-db-password = {
      file = ../../../../secrets/traccar-db-password.age;
      path = "/run/secrets/traccar-db-password";
      owner = "postgres";
      group = "postgres";
    };
    traccar-smtp-token = {
      file = ../../../../secrets/traccar-smtp-token.age;
      path = "/run/secrets/traccar-smtp-token";
      owner = "traccar";
      group = "traccar";
    };
    locationiq-access-token = {
      file = ../../../../secrets/locationiq-access-token.age;
      path = "/run/secrets/locationiq-access-token.age";
      owner = "traccar";
      group = "traccar";
    };
  };
  services.traccar = {
    environmentFile = config.ragenix.secrets."traccar-account-backup-token.age".path;
    enable = true;
    settings = {
      # Database settings
      "database.user" = "traccar";
      "database.url" = "jdbc:postgresql://localhost/traccar";
      "database.passwordFile" = "/run/secrets/traccar-db-password";
      # Devices settings
      "osmand.port" = "5055";
      # Web settings
      "web.port" = "8082";
      "web.url" = "https://traccar.bell-peppers.com";
      "web.address" = "127.0.0.1";
      "server.timeout" = "600";
      # Smtp settings
      "mail.smtp.host" = "smtp-relay.proton.me";
      "mail.smtp.port" = 587;
      "mail.smtp.from" = "zachary@bell-peppers.com";
      "mail.smtp.username" = "zachary@bell-peppers.com";
      "mail.smtp.passwordFile" = "/run/secrets/traccar-smtp-token";
      "mail.smtp.starttls.enable" = true;
      # Filter settings
      "filter.enable" = true;
      "filter.invalid" = true;
      "filter.zero" = true;
      "filter.duplicate" = true;
      "filter.future" = true;
      "filter.maxSpeed" = "85";
      # Geolocation settings
      "geocoder.enable" = true;
      "geocoder.type" = "locationiq";
      "geocoder.key" = builtins.readFile ./locationiq-key.txt;
      "geocoder.onRequest" = true;
      # Backup account token
      "web.serviceAccountToken" = "$TRACCAR_SERVICE_TOKEN";
    };
  };
}
