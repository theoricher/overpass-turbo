# overpass-turbo Docker image

Automated Docker image build of [overpass-turbo](https://github.com/tyrasd/overpass-turbo), the web-based data mining tool for OpenStreetMap.

## How it works

A GitHub Actions workflow runs every day at 6am UTC and checks the latest commit on the upstream `master` branch. If no image with that commit's short SHA already exists on Docker Hub, it builds and pushes a new multi-arch image (`linux/amd64`, `linux/arm64`).

## Usage

```bash
docker run -p 8080:80 theoricher/overpass-turbo
```

Then open [http://localhost:8080](http://localhost:8080).

## Configuration

The following environment variables can be set at runtime to override compiled-in defaults:

| Variable | Default | Description |
|---|---|---|
| `DEFAULT_SERVER` | `https://overpass-api.de/api/` | Overpass API endpoint |
| `DEFAULT_TILES` | `https://tile.openstreetmap.org/{z}/{x}/{y}.png` | Tile server URL |

```bash
docker run -p 8080:80 \
  -e DEFAULT_SERVER=https://my-overpass.example.com/api/ \
  -e DEFAULT_TILES=https://my-tiles.example.com/{z}/{x}/{y}.png \
  yourusername/overpass-turbo
```

## Tags

| Tag | Description |
|---|---|
| `latest` | Latest build from upstream `master` |
| `<short-sha>` | Build pinned to a specific upstream commit (e.g. `a3f9c12`) |