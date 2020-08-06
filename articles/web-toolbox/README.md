![preview](./preview.png)
Essential toolbox for the web 🧰
===============================

218; 12020 H.E.

Abstract
--------

Internet is a great place for content and cat videos, but also really
bad stuff, like traumatizing advertisements, endless user data
collection, and straight-up spying. This page is a soft introduction
into some tools, services, browser extensions you can use to get back
control of your online presence.

*Call it an internet usage etiquette.* -- Matthew, my friend

Adblockers
----------

Allowing people use the Internet without an adblocker is a violation of
Geneva Conventions. What an adblocker does is block ads and those noisy
webpage elements that jump at you or show unholy pictures. More on that
[here](https://en.wikipedia.org/wiki/Online_advertising).

There is an adblocker that\'s called [AdBlock](https://getadblock.com/),
however, after years of using it, I now prefer
[uBlock](https://ublock.org/). It just seems to be faster and simpler to
use. The extensions automatically block all known advertising sources.
You can also block specific elements manually.

Trackers
--------

[Browser
tracking](https://edu.gcfglobal.org/en/internetsafety/understanding-browser-tracking/1/)
is one of those evil things that came into web couple of years ago.
Essentially, every time you visit a website, it saves a small piece of
data in your browser (cookie), where later it will allow any other
website to track your browsing history and activity. Cookies are
essential for services, as it helps you to stay logged in and make your
browsing experience more comfortable. As everything, it gets misused
pretty often.

[Privacy Badger](https://privacybadger.org/) automatically learns to
block invisible trackers. Some random websites out of nowhere should not
be able to know what pages you looked at and where you\'re heading off
next.

Browser scripts
---------------

[JavaScript](https://en.wikipedia.org/wiki/JavaScript) is one of the
saddest technological developments that we wholeheartedly embraced. JS
is code that runs in your browser. Almost all of the buttons you
clicked, forms filled, animations played, and even pages loaded is
JavaScript. It\'s so critical for everything that it gets abused more
than anything else. Any website can run arbitrary code in your browser,
which can create any number of questionable actions executed on your
behalf.

[Device fingerprint](https://en.wikipedia.org/wiki/Device_fingerprint),
[unstoppable tracking](https://en.wikipedia.org/wiki/Evercookie),
[browser sniffing](https://en.wikipedia.org/wiki/Browser_sniffing), and
etc. exist because any random code can run on your machine without you
even knowing it.

[NoScript](https://noscript.net/) pre-emptively blocks scripts running
in your browser. You will get a manual but full control of all code
sources, where you will be able to allow or block specific resources. It
is a bit inconvenient the first time you use it, as websites tend to
over-rely on JS just for loading. Couple of days in, I allowed some
specific JS sources and it never bothered me again.

IP Tracking
-----------

By the definition of how we do networking, every web resource is able to
see the origin\'s (user\'s) IP address, thus the unique web identifier
of the Internet. It takes no effort to [trace IP
back](https://en.wikipedia.org/wiki/IP_traceback) to ISPs, precise
locations, and even individuals. The most popular way of \"hiding\" your
IP address is using VPN services.

This is how naked connections looks like, it may not even be secured and
there might be an eavesdropper in the middle!

                                     ┌────────────────┐
    ┌─────┐      ──> Your IP         │                │
    │ You ├──────────────────────┬───│  THE INTERNET  │
    └─────┘      <── Data        │   │                │
                                 │   └────────────────┘
                                 │
                                 │
                           ┌─────┴────────┐
                           │ Eavesdropper │
                           └──────────────┘

VPN is basically accessing the internet goods through a secure
middle-man that ideally keeps your identity secret and takes the main
hit of being exposed to everything out there

                                     ┌────────────────┐
    ┌─────┐     ┌─────┐ ──> VPN IP   │                │
    │ You ├─────┤ VPN ├──────────┬───│  THE INTERNET  │
    └─────┘     └─────┘ <── Data │   │                │
                                 │   └────────────────┘
                                 │
                                 │
                           ┌─────┴────────┐
                           │ Eavesdropper │
                           └──────────────┘

You were probably bombarded by millions of different VPN ads, like
**NordVPN**, **ProtonVPN**, **BearVPN**? There are some you should NOT
use. Like [UFO
VPN](https://www.comparitech.com/blog/vpn-privacy/ufo-vpn-data-exposure/),
they made a promise of not storing the original plain data and keep no
logs (user activity traces). They did.

I personally would recommend [Mullvad VPN](https://mullvad.net/en/). It
is the fastest VPN out there that deploys latest VPN standards
(Wireguard) and most privacy-respectful. It\'s priced at ridiculously
fair \$5/mo. No personal data. Creating a mullvad \"account\" (just a
collection of numbers) takes no time. You can actually pay for mullvad
access with cash. Anonymously mail cash with your account number and
it\'s loaded.
