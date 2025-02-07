---
layout: post
title:  "Harden Cloud Linux Server"
date:   2025-02-06 18:21:39 -0700
categories: security
---

I often spawn a cloud linux server to test out new ideas. But always worry about
security of these servers because if you leave a publicly available server online
even for a few hours, you'll start to see a lot of failed login attempts from IPs
all over the world.

So, when I launch a linux server on the cloud, I follow the following setups:

## Disable Passwords

I always double check the following sshd configuration options. I only login
with SSH keys, and not with passwords or any other authentication methods.

```bash
# Disable root login
PermitRootLogin prohibit-password

# Disable password login
PasswordAuthentication no

# Challenge response authentication
ChallengeResponseAuthentication no

# PAM authentication
UsePAM no
```

## Additional Security Measures

If the server is going to be running for a while, then I change the SSH port.

```
# Change SSH port to some random port above 1024
Port 2222 # Some Random Port Above 1024
```

Ofcouse, a commited hacker can still scan the ports, but this will atleast mitigate
automated bots attacks, that try to brute force the default port -- the primary
attack vector I am trying to mitigate.

## Setup Firewall

If the cloud provider supports it, I enable the firewall from the cloud console,
otherwise use `ufw` to block all incoming traffic on all ports except the ports
that need incoming traffic such as HTTP (80) and HTTPS (443) for example.

And for SSH port, I ensure that only my IP has access to it, but again IP addresses
can change, and this can get annoying to keep whitelisting new IPs.

That's it!

There are more things you could do, for example, setting up 2-Factor Authentication,
and `fail2ban` to harden the server futher, but these are good enough for me.
