{ config, pkgs, ... }:
{
  users.users.lenni = {
    openssh.authorizedKeys.keys = [''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzQEYS0fsylcZJRr9L3Bu1UP99hHWsw3euV7CIfzFRAyjrLORf904MqM8S6fnu7I+GtyDezOXR8W+3XktXVik6pnvmpHWpUWPpt7/sGG8uM3j49B0qXXz5oEe28YBFWYvYAcRCXsoXErNmVg0ZsuVJphDSKsOWYbdCtDTX95fJUUwNaJbj2dxZe4FShdc0zTJjyOdSW5LMWbYPrIXqxYd+6+WyL4XPNLgtVbivldQ0ASgtpb1JsYsu6AQ4HVeBsX69n4GwkdXDk8WohlGh7pYPQwRnBWY9PURvmkcZ0BgxWaSjVP0SXEq8KLYgii5TVMh0N93iHYn7Ifilm8Z4z/VpA+FX9c/zYaGyrpXOqE0BYb92cDYFN8uNQMVRokQ/luDd6rJjgbPPyvm5jo8TodHZnAnzNpEY8YqTAJuGou+st7ftiVG2NSzRO/jSfPZ84behffVvVQSy2CGPzWnfRpDQog6pVEKATquM8BBQ74TQUtmUbHfhwqkrzPsapo2LmWU= lenni@PC'' ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUwLO6G/7x5rt8BuJuyNf9MXmqvutHMyptUESOrmLjSFsrZmgeL78PV9nVwd3G252DLsM8bciQKUeQVTJqlwAC5CBvHuNN1ZZwTO/iQYbmwXxf8snzogU++8tFMkRwGOuO8CXymUFGEkD9xdYd7B53ZXDYcfaddajWI/SjvdK7tPHoBRcrIBoLMgvfeOdLUM2fyoxgZnGZbWw7DuUBq2tEw3o4GZkfJSIjZy37Nkxtrmo1qSOiig+kKbtDX2aK3jkBmSnzv7SA8n5J1xq0iy0ploDv7UJwBB+DX/OTQNNgIAXiK3oRb447+QhCR0hhpNZ43sRpKl+dlphlXWtjzfSFLXyzaM4ns14KqNuBkOcO6SJokS1Les2sJ2W+WEdQzRkPCCdAp7/mS1mHECTGymozRgDmKi7QtYSCjOBJ+wO3ZfoR/SUbxUwZopK3JQi0T0B49h99LB+gJf4uULrzA361WtOj7rYBzGSUYWGE5tdQd4tSu2jx6KStXEC9mffO/yE= TERMIUS'' ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDB+OBXa6vRSV4SvmKNr77KrlhHVLRJ31cABlLQqFIM4 Lenni'' ];
    isNormalUser = true;
    description = "Lenni Hein";
    extraGroups = [ "networkmanager" "wheel" "shared-data" ];
    shell = pkgs.fish;
  };
}
