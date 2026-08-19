{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.authelia.instances.main = {
    enable = true;

    # Secrets files generated on startup by our preStart script
    secrets = {
      jwtSecretFile = "/var/lib/authelia-main/jwt-secret";
      sessionSecretFile = "/var/lib/authelia-main/session-secret";
      storageEncryptionKeyFile = "/var/lib/authelia-main/storage-key";
    };

    settings = {
      theme = "dark";
      default_2fa_method = ""; # Allow logging in with 1FA directly without forcing TOTP setup

      server = {
        address = "tcp://127.0.0.1:9091";
      };

      log = {
        level = "info";
      };

      authentication_backend = {
        file = {
          path = "/var/lib/authelia-main/users.yml";
          password = {
            algorithm = "argon2id";
          };
        };
      };

      storage = {
        local = {
          path = "/var/lib/authelia-main/db.sqlite3";
        };
      };

      session = {
        name = "authelia_session";
        same_site = "lax";
        inactivity = "1h";
        expiration = "12h";
        remember_me = "30d";
        cookies = [
          {
            domain = "bes.lennihein.com";
            authelia_url = "https://auth.bes.lennihein.com";
          }
        ];
      };

      access_control = {
        default_policy = "one_factor"; # 1FA password access only for simple testing
        rules = [
          {
            domain = "secure.bes.lennihein.com";
            policy = "two_factor";
          }
          {
            domain = [
              "terminal.bes.lennihein.com"
              "terminal-seth.bes.lennihein.com"
              "terminal-sobek.bes.lennihein.com"
              "headplane.bes.lennihein.com"
            ];
            policy = "one_factor";
            subject = [ [ "group:admins" ] ];
          }
        ];
      };

      webauthn = {
        enable_passkey_login = true;
      };

      notifier = {
        disable_startup_check = true;
        filesystem = {
          filename = "/var/lib/authelia-main/notification.txt";
        };
      };
    };
  };
}
