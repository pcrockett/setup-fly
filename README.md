# setup-fly action

easy way to install [flyctl](https://fly.io/docs/flyctl/) in your GitHub Actions
workflows.

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@9c091bb21b7c1c1d1991bb908d89e4e9dddfe3e0  # v7.0.0
      - uses: pcrockett/setup-fly@c59149fa58c215cf1e961bec2ffb53f0a21c2e85 # v0.1.0
```

if you don't want to use the default version of flyctl that comes with this action, you
can specify your own version and checksum:

```yaml
- uses: pcrockett/setup-fly@c59149fa58c215cf1e961bec2ffb53f0a21c2e85 # v0.1.0
  with:
    version: '0.4.61'
    checksum: '160763f890703dd0cb06588f14d739604778af4a2657e9af6d6d32786487cc60'
```

**recommended:** run [pinact](https://github.com/suzuki-shunsuke/pinact) to pin your
actions to a specific release. don't worry, if you're using Dependabot, Renovate, etc.,
they will update your pins correctly for you.

```bash
pinact run --update
```
