## Stack
Apache Kafka integration service. Docker-based deployment. Language and framework versions not detectable from available metadata.

## Constraints
Never modify:
- `docker-compose.yml` and any `docker-compose.*.yml` override files
- `Dockerfile` (build reproducibility)
- Any `*.lock` or `lock.*` files
- Any file containing credentials, secrets, or environment variables: `.env`, `*.env`, `secrets.*`
- Generated configuration files output by build steps
- Kafka topic/partition configuration files if declared as static assets

## Conventions
- Repository contains 10 tracked files — changes are high-impact; modify only the specific file required
- Kafka configuration tuning targets broker/producer/consumer property files (e.g. `server.properties`, `kafka.properties`, or equivalents)
- CVE and dependency scans operate read-only; do not commit scanner output files
- Security agent operates on grep output only; do not modify source files without explicit instruction from `infra_remediation`
- `infra_remediation` agent acts only when instructed by an upstream investigation agent (h1/h2/h3); do not self-initiate changes

## Dependency manifests
Exact filenames not detectable; check for:
- `requirements.txt`, `Pipfile`, `pyproject.toml` (Python)
- `package.json` (Node)
- `go.mod` (Go)
- `pom.xml` or `build.gradle` (JVM)
- `Dockerfile` `FROM` lines as the authoritative runtime version source
