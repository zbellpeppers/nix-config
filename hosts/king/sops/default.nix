{config, ...}: {
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml; # Relative path from this nix file to the encrypted secret file
    # Or if you used secrets.enc.yaml:
    # defaultSopsFile = ../../secrets/secrets.enc.yaml;

    # Enable decryption using the host's SSH keys during activation.
    # This is the most common and secure method for deployment.
    age.sshKeyPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/home/zachary/.ssh/id_ed25519"
    ];

    # Define secrets and how they should be made available on the system
    secrets = {
      cf_dns_token_file = {
        # No need to specify 'sopsFile' if using defaultSopsFile
        key = "cf_dns_token"; # The key in your secrets.yaml
        # ddclient usually runs as root, so root ownership is appropriate
        owner = config.users.users.root.name;
        group = config.users.groups.root.name; # Or just "root"
        mode = "0400"; # Read-only for root is secure
        # The decrypted token will be placed in /run/secrets/cf_dns_token_file
      };

      # Example: Using a host-specific secrets file
      # king_specific_secret = {
      #   sopsFile = ../../secrets/king-secrets.yaml; # Point to the specific file
      #   key = "some_king_only_value";
      #   owner = config.users.users.zachary.name;
      #   mode = "0400";
      # };
    };
  };
}
