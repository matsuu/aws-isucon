# isucon7-qualify

## Overview

ISUCON7予選をAWS環境で構築するためのPacker Templateです。


サーバ内の構築にはAnsibleを使っています。Ansibleのplaybookのみ必要な場合は[matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)をどうぞ。

## Build

```sh
${EDITOR} variables.pkr.hcl
packer build .
```

## Related

- [ISUCON](https://isucon.net/)
- [matsuu/aws-isucon](https://github.com/matsuu/aws-isucon)
