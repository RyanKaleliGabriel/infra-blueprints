## Understanding DNS, Public vs Private IPs, and Web Server Routing in Onsite Networks

> This documentation covers, domain routing, IP infrastructure and how services like nginx handle web traffic 

# How It All Works — In a Nutshell

 1. Domain and subdomain

    - Register a domain on a domain name resolver/provider like namecheap
    - Depending on your needs, you can choose to use a subdomain or a domain for your site, and add a A record pointing to your server's public ip
    - A record, maps a domain/subdomain to an IP address (e.g., 102.209.153.91).
    - CNAME, Points one domain to another domain
    - MX Record, Email routing
    - TXT Record, Text notes (often for verification or security) 
  
 2. Public vs Private IPs:

    - A server has
      - A public IP for internet access. A public IP provided by your organization’s ISP (especially if you host onsite). It’s reachable from anywhere on the internet.
      - A private IP for internal/local access over Ethernet. This is used inside your local network. It's not accessible from the internet directly.
    - When someone visits the site, their request goes to the public IP.
    - Your router/firewall forwards this to the server’s private IP.

 3. Ethernet + Direct Connection
    
    - Your server is physically connected via Ethernet, giving it a static private IP within the internal network.
    - Internet traffic still arrives through the public IP, but gets routed internally to the server through the Ethernet connection.

 4. Nginx Role

    - Nginx is the web server running on the server.
    - It listens on port 80 (HTTP) and port 443 (HTTPS).
    - It serves the correct site (e.g., yourdomain.com or yoursubdmomain.com) based on its config.
    
 5. HTTP/HTTPS & Ports

    - The browser picks HTTP (port 80) or HTTPS (port 443) based on the URL scheme.
    - Port forwarding is set on your router to allow traffic from those ports to reach the server.

# Final Flow

  ```

  User → yoursubdomain.com
      ↓
  Namecheap DNS → Resolves to public_ip (public IP)
      ↓
  Router receives request on port 80/443
      ↓
  Router forwards to server’s private IP over Ethernet
      ↓
  Nginx handles request and serves the site

  ```

## Questions

  1. When someone clicks the subdomain, how does it reach our server?

     ✅ The subdomain yoursubdomain.com is registered on Namecheap, which has a DNS A record pointing to your server’s public IP.

     ```
     Browser → DNS lookup → gets 102.209.153.91
     → Sends request to that IP on port 80 (HTTP) or 443 (HTTPS)
     → Router receives it → Forwards to server’s private IP (e.g., 192.168.x.x)
     → Nginx on the server responds with the correct website
     ```

  2. Is 102.209.153.91 a public IP?
     
     ✅ Yes. It’s a public IP, likely assigned by your ISP or network administrator, and is reachable from anywhere on the internet.

  3. Can the request "skip" the private IP and go directly to Nginx using the public IP?
     
     ❌ No. The public IP belongs to the router, not directly to the server.

     ➡️ The router forwards the request to the server's private IP (within the LAN via Ethernet).
    
  4. Where is the port forwarding defined?

     ✅ It’s defined in your router or firewall settings, not in Nginx.
     You set rules like:

     ```
     Public IP:80 → Private IP:80
     Public IP:443 → Private IP:443
     ``` 

   5. How does the browser know whether to use HTTP or HTTPS?
      
      ✅ Based on the URL scheme:

      http:// → browser uses port 80

      https:// → browser uses port 443

      You can manually specify other ports if needed (e.g., http://example.com:8080)

      If you want HTTPS, the server must have an SSL certificate installed, and Nginx must be configured to handle it.

   6. Does Namecheap give a public IP address when registering a subdomain?
      
      ❌ No.

      ✅ You must manually set the IP address (usually a public one you already own) when creating a DNS A record.

   7. Final flow

      ```
      [Internet User]
            ↓
      types: yoursubdomain.com
            ↓
      DNS Lookup → Namecheap resolves to 102.209.153.91 (public IP)
            ↓
      Router (owns public IP) receives request on port 443
            ↓
      Router forwards to internal server (e.g., 192.168.1.10) over Ethernet
            ↓
      Nginx receives request and serves the site based on server_name
      ```

