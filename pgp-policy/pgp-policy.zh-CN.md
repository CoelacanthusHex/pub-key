---
title: PGP 密钥签名策略
lang: zh-CN
---

以下是我签名他人密钥时遵守的流程。\
（[English Version](./pgp-policy.en.html)）
（[正體中文版本](./pgp-policy.zh-TW.html)）
（[纯文本版本](./policy.txt)）

## 概要

本策略适用于以下密钥所做出的签名：
```
sec   ed25519/0x15F4180E73787863 2021-07-14 [C] [expires: 2027-01-01]
      Key fingerprint = 892E BC7D C392 DFF9 C9C0  3F1D 15F4 180E 7378 7863
uid                   [ultimate] Coelacanthus <coelacanthus@outlook.com>
uid                   [ultimate] Coelacanthus <CoelacanthusHex@gmail.com>
uid                   [ultimate] Coelacanthus <i@coelacanthus.moe>
uid                   [ultimate] Celeste Liu (For AOSC) <coelacanthus@aosc.io>
ssb>  ed25519/0xE35C89E45867AE35 2021-07-14 [S] [expires: 2027-01-01]
      Key fingerprint = 16B9 E5EB A675 E2F0 A60D  3498 E35C 89E4 5867 AE35
ssb>  cv25519/0x7C20D9B5ED32703C 2021-07-14 [E] [expires: 2027-01-01]
      Key fingerprint = C943 E5E3 7E4B AC37 AA1F  AE6E 7C20 D9B5 ED32 703C
ssb>  ed25519/0x06F96A0FB5AD258D 2021-07-14 [A] [expires: 2027-01-01]
      Key fingerprint = 8977 A899 55F9 0095 55E9  D344 06F9 6A0F B5AD 258D
```

你可以通过以下方式获取到我的 PGP 密钥：

- `gpg --keyserver hkps://keys.gnupg.net --recv-keys 892EBC7DC392DFF9C9C03F1D15F4180E73787863`
- `gpg --fetch-keys 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x892ebc7dc392dff9c9c03f1d15f4180e73787863'`
- `gpg --fetch-keys 'https://pgp.mit.edu/pks/lookup?op=get&search=0x15F4180E73787863'`
- `gpg --fetch-keys 'https://pgp.surf.nl/pks/lookup?op=get&search=0x15F4180E73787863'`
- `gpg --fetch-keys 'https://pgp.gnd.pw/pks/lookup?op=get&search=0x892ebc7dc392dff9c9c03f1d15f4180e73787863'`
- `gpg --fetch-keys https://keybase.io/coelacanthus/key.asc`

以及二维码

[![](../public-key.png)](https://pgp.coelacanthus.moe/public-key.png)

**请注意**

- 使用 `--recv-keys` 导入密钥时务必使用完整的密钥 ID ，有资料显示，密钥碰撞是可行的。
- 使用 `--recv-keys` 导入密钥时请使用 `hkps://keys.openpgp.org` 作为 keyserver，使用 其他 keyserver 可能让你受到 [Certificate Flooding Attack](https://dkg.fifthhorseman.net/blog/openpgp-certificate-flooding.html) 。

需要注意的是，在公钥服务器群上，存在三个和我使用相同名称的公钥，他们是我曾经的测试公钥以及他人伪造的公钥，具体情况请参见我的[密钥所有权声明](https://pgp.coelacanthus.moe/key-ownership-statement.txt)。

本策略最初撰写于 2021-08-16 且从此日期开始执行，不过也随时可能被更新版本替代。本文档的结构和内容系受到 Allen Zhong 的 [PGP 密钥签名策略](https://atr.me/~pgp/policy-cn.html) 以及 Outvi V 的 [GPG 签名方针](https://blog.outv.im/p/gpg-policy/) 启发。

## 签名策略

### 签名级别

依据 GPG 手册和 [OpenPGP Message Format](https://datatracker.ietf.org/doc/html/rfc4880)，现将签名分为以下四种等级：`Generic (0)`, `Persona (1)`, `Casual (2)`, `Positive (3)`。

-	Level 0 (普适认证)

> 不会作出，以保证信任等级的单调递增。

-	Level 1 (个人认证)

> 我对其不做任何保证。

-	Level 2 (谨慎认证)

> 仅当我在线下与其见面并验证其身份（或者其他同等级的验证手段）才会签署，我已验证该密钥、使用的邮件地址与社会实体的关联性。

-	Level 3 (积极认证)

> 我相信此 GPG pubkey 的私钥控制者是可信的，对 GPG 有一定理解，并能够合理地对其它人进行签名。

注意，因为 GNUPG 的默认配置，Level 0 认证被认为是可信签名，但是 Level 1 不被认为是可信签名（即不参与信任链的构建），请知悉。本人针对这一情况，决定将**不会作出 Level 0 签名**。

### 签名流程

#### Level 1

你需要给我发送一封申请 Level 1 签名的邮件,其内容包括：

-	密钥指纹
-	密钥被上传至哪一个密钥服务器
-	希望我签名的 UID, 若希望我签名所有 UID 则此项可留空
-	关于希望获得 Level 1 签名的一些说明

该邮件应以待签署密钥签名并以我的公钥加密。

#### Level 2

在线下见面时发生。

### 公平性原则

对于我请求他人做出的签名，我会（按照对方的签名策略）以相同级别签署对方的密钥。同时，我也希望从我所签署的密钥的持有者处获得与我所作出的相同级别的签名。

我希望对密钥进行交叉签名，所以若被签署人并不愿意签署我的密钥，则向我提出签名请求不具有任何意义。

## Changelog

- 2021-08-16: 初稿
- 2022-02-20: 添加 MIT 和 Ubuntu 的公钥服务器
- 2022-02-24: 添加二维码
- 2022-02-24: 仅作出 Level 2 和 3 等级的签名
- 2022-03-13: 纠正拼写错误
- 2022-03-13: 移除 keys.openpgp.org，因为它不会保留签名
- 2022-03-13: 修正 Outvi V 的签名方针链接
- 2022-03-13: 修正将作出的签名等级

## 授权

Copyright (C) 2021-2022 Celeste Liu.

Permission is granted to copy, distribute and/or modify this document under the terms of the [GNU Free Documentation License](https://www.gnu.org/licenses/fdl.html), Version 1.3 or any later version published by the Free Software Foundation.

> A signed version of this documentation is available at:
> https://pgp.coelacanthus.moe/policy-signed.txt
