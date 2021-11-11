
# Open Anti-Bot Box

Vagrantfile with Ubuntu, Varnish, Apache, ModSecurity, and toy web app.

```
vagrant up
```

See toy web app come live on host port 5000.

```
http://127.0.0.1:5000/status/406
```

Look at the response to see Varnish has "spoof-blocked".
