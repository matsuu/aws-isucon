# isucon9-final

## Overview

ISUCON9本選をAWS環境で構築するためのPacker Templateです。

サーバ内の構築にはシェルスクリプトを使っています。

## Build

```sh
${EDITOR} variables.pkr.hcl
packer build .
```

## Related

- [ISUCON](https://isucon.net/)
- [matsuu/aws-isucon](https://github.com/matsuu/aws-isucon)
