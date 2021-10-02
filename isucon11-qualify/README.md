# isucon11-qualify

## Overview

ISUCON11予選をAWS環境で構築するためのPacker Templateです。


サーバ内の構築にはAnsibleを使っています。Ansibleのplaybookのみ必要な場合は[isucon/isucon11-qualify](https://github.com/isucon/isucon11-qualify)をどうぞ。

## Build

```sh
${EDITOR} variables.pkr.hcl
packer build .
```

## Related

- [ISUCON](https://isucon.net/)
- [matsuu/aws-isucon](https://github.com/matsuu/aws-isucon)
