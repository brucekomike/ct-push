# ct-push

Shell scripts to push multiple container images to a remote SSH host using
`docker save` / `docker load`.

## Usage

```
ct-push <host> <config>
```

- **host** – SSH destination (e.g. `user@192.168.1.10`)
- **config** – path to a config file that lists the images to push

Example:

```bash
./ct-push myuser@remote.host configs/config1
```

## Config files

A config file is a plain-text file where each line names a container image.
Lines that begin with `#` (or are blank) are skipped, so you can comment out
images you want to skip:

```
# this image is skipped
jonasal/nginx-certbot:latest
nginx:trixie
# mariadb:12.1.2-noble   ← also skipped
```

## Workflow

1. Copy a template from `templates/` into `configs/`:

   ```bash
   ./copy.sh config1          # copy one template
   ./copy.sh                  # copy all templates
   ```

2. Edit the copied file in `configs/` to comment out any images you don't need.

3. Run `ct-push`:

   ```bash
   ./ct-push myuser@remote.host configs/config1
   ```

The script will:
1. `docker pull` every listed image locally.
2. Pipe all images in a single `docker save` stream to the remote host via SSH,
   where `docker load` imports them.

## Templates

| Template  | Description |
|-----------|-------------|
| `config1` | Miscellaneous services (nginx, MariaDB, Trilium, MediaWiki, frp, …) |
| `config2` | `ghcr.io/brucekomike` cct images |
