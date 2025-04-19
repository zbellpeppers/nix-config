Greetings friends. This is my nixos config and the explanation behind it. I utilized several main sources when crafting this. The first and most important was: https://github.com/sioodmy/dotfiles. The second is the nixos options search, its tips, and skimming source code as needed.

Lets break down each section!

1. desktop-envs
   This folder contains the various desktop environments, and the configs specific to ONLY those desktop environments. My wife was using pantheon but, for long-term use, I have opted to install elementary os on her computer. I personally use plasma and the gnome config is very much not fleshed out but will at least get gnome up and running with a nixos-rebuild boot.
2. home-manager
   Here we have two situations. First, the host specific home-manager configs being EITHER king or queen. My pc or my wife's, which then calls the common home-manager config, settings, etc. Note: This will not enable the home-manager commands. You don't run home-manager switch to update home-manager but use nixos-rebuild.
3. hosts
   This defines the two possible systems via a customized function 'mkhost'. You can define the host in multiple ways. One via 'sudo nixos-rebuild switch --flake .#king' (or .#queen). Another if installing from scratch via 'sudo nixos-install --flake .#king' (or .#queen). This mkhost is what defines which desktop environment you'll be using as well as which of the home-manager hosts you'll be using. the ? means that, if left as null, it will default to what follows.
4. modules
   Here is where my custom nixos modules would go, If I had any! Currently there is only a nix config to generate a nixos installation image. It's extremely convenient to be able to specify the system settings for a nixos-iso before its generated so I don't have to mess with keyboard settings.
5. overlays
   This section is for overlays which I generally only use when something breaks. I don't currently use any packages or other things that require extensive overlays and do them in-line. When things break or fail to build, I usually am able to find an already generated github issue with the fix and I then rip that fix and then add an overlay for it.
6. secrets
   I utilize sops-nix. Instructions for that can be found at 'https://github.com/Mic92/sops-nix'. I found them extremly confusing though and had to ask for help. I intend on switching to agenix soon.
7. system
   This is the main system config that is shared by all hosts. You could do something similar with the home-manager  setup and delegate a section for each host that then calls a common config, but I built two roughly identical pcs for my wife and I so that wasn't needed. The parts that differ are included in hosts.
8. Flake and scripts
   Finally we have the flake.nix, with the majority of its contents being called in the hosts/default.nix. My flake.nix is very simple because it delegates most of the calling to hosts/default.nix. It will NOT function with hosts. Each script and what it does:
   1. gitupdate.sh: This will create a temporary copy of the current /etc/nixos. Then copy the contents of ~/nix-config to /etc/nixos, ignoring the .git. It will then attempt the rebuild that you specified via fish alias, such as 'upgit test' 'upgit boot' 'upgit switch'. Or you can simply run 'upgit' and it will default to switch. It will then ask for a commit message for git or, if you enter through it, generate a message based on the current date and a build id. Then the rebuild starts, should it succeed, the current nix-config is committed and pushed. Else, it fails and you need to fix the source of the errors then try again. Note: upgit test will not perform git actions, its best to run upgit test after making changes until it works then upgit and inputting the git commit message manually.
   2. update-plasmamanager.sh: This script runs 'nix run github:nix-community/plasma-manager --dump', formats the contents as needed to be valid nix code, then overwrites home-manager/king/plasma-manager/default.nix with the contents. You must do this everytime you want a change to your plasma environment to stick as the next nixos-rebuild will overwrite the current plasma settings with the outstanding plasa-manager dump.

I hope this helps. If you have any suggestions, comments, questions, please feel free to contact me on discord directly or in the nixos discord channel. My user is KingSK
