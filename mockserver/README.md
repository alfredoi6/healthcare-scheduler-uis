# Mock Server

A mock server for development using json-server with HTTPS support.

## SSL Certificate Setup

The mock server uses locally trusted SSL certificates generated using `mkcert`. Here's how to set it up:

1. Install mkcert:
   ```bash
   # Windows (using chocolatey)
   choco install mkcert

   # macOS (using homebrew)
   brew install mkcert
   ```

2. Create a local Certificate Authority:
   ```bash
   mkcert -install
   ```

3. Generate SSL certificates:
   ```bash
   # Create ssl directory
   mkdir ssl
   cd ssl

   # Generate certificates for localhost and local IP
   mkcert localhost 127.0.0.1 ::1 192.168.86.30
   ```

   This will create two files:
   - `localhost+3-key.pem`: Private key
   - `localhost+3.pem`: Certificate

4. Rename the files to match the server configuration:
   ```bash
   mv localhost+3-key.pem localhost+2-key.pem
   mv localhost+3.pem localhost+2.pem
   ```

## Running the Server

1. Install dependencies:
   ```bash
   yarn
   ```

2. Start the HTTPS server:
   ```bash
   yarn mock-server-https
   ```

The server will be available at:
- https://localhost:4000
- https://192.168.86.30:4000

Note: When accessing the server for the first time, you'll need to accept the self-signed certificate warning in your browser. This is safe because you generated the certificate locally.