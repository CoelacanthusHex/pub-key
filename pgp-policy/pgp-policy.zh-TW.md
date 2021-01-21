---
title: PGP 金鑰簽名策略
lang: zh-TW
---

以下是我簽名他人金鑰時遵守的流程。\
（[English Version](./pgp-policy.en.html)）
（[简体中文版本](./pgp-policy.zh-CN.html)）
（[純文字版本](./policy.txt)）

## 概要

本策略適用於以下金鑰所做出的簽名：
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

你可以透過以下方式獲取到我的 PGP 金鑰：

- `gpg --keyserver hkps://keys.gnupg.net --recv-keys 892EBC7DC392DFF9C9C03F1D15F4180E73787863`
- `gpg --fetch-keys 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x892ebc7dc392dff9c9c03f1d15f4180e73787863'`
- `gpg --fetch-keys 'https://pgp.mit.edu/pks/lookup?op=get&search=0x15F4180E73787863'`
- `gpg --fetch-keys 'https://pgp.surf.nl/pks/lookup?op=get&search=0x15F4180E73787863'`
- `gpg --fetch-keys 'https://pgp.gnd.pw/pks/lookup?op=get&search=0x892ebc7dc392dff9c9c03f1d15f4180e73787863'`
- `gpg --fetch-keys https://keybase.io/coelacanthus/key.asc`

以及二維碼

[![](../public-key.png)](https://pgp.coelacanthus.moe/public-key.png)

**請注意**

- 使用 `--recv-keys` 匯入金鑰時務必使用完整的金鑰 ID ，有資料顯示，金鑰碰撞是可行的。
- 使用 `--recv-keys` 匯入金鑰時請使用 `hkps://keys.openpgp.org` 作為 keyserver，使用 其他 keyserver 可能讓你受到 [Certificate Flooding Attack](https://dkg.fifthhorseman.net/blog/openpgp-certificate-flooding.html) 。

需要注意的是，在公鑰伺服器群上，存在三個和我使用相同名稱的公鑰，他們是我曾經的測試公鑰以及他人偽造的公鑰，具體情況請參見我的[金鑰所有權宣告](https://pgp.coelacanthus.moe/key-ownership-statement.txt)。

本策略最初撰寫於 2021-08-16 且從此日期開始執行，不過也隨時可能被更新版本替代。本文件的結構和內容系受到 Allen Zhong 的 [PGP 金鑰簽名策略](https://atr.me/~pgp/policy-cn.html) 以及 Outvi V 的 [GPG 簽名方針](https://blog.outv.im/p/gpg-policy/) 啟發。

## 簽名策略

### 簽名級別

依據 GPG 手冊和 [OpenPGP Message Format](https://datatracker.ietf.org/doc/html/rfc4880)，現將簽名分為以下四種等級：`Generic (0)`, `Persona (1)`, `Casual (2)`, `Positive (3)`。

-	Level 0 (普適認證)

> 不會作出，以保證信任等級的單調遞增。

-	Level 1 (個人認證)

> 我對其不做任何保證。

-	Level 2 (謹慎認證)

> 僅當我線上下與其見面並驗證其身份（或者其他同等級的驗證手段）才會簽署，我已驗證該金鑰、使用的郵件地址與社會實體的關聯性。

-	Level 3 (積極認證)

> 我相信此 GPG pubkey 的私鑰控制者是可信的，對 GPG 有一定理解，並能夠合理地對其它人進行簽名。

注意，因為 GNUPG 的預設配置，Level 0 認證被認為是可信簽名，但是 Level 1 不被認為是可信簽名（即不參與信任鏈的構建），請知悉。本人針對這一情況，決定將**不會作出 Level 0 簽名**。

### 簽名流程

#### Level 1

你需要給我傳送一封申請 Level 1 簽名的郵件,其內容包括：

-	金鑰指紋
-	金鑰被上傳至哪一個金鑰伺服器
-	希望我簽名的 UID, 若希望我簽名所有 UID 則此項可留空
-	關於希望獲得 Level 1 簽名的一些說明

該郵件應以待簽署金鑰簽名並以我的公鑰加密。

#### Level 2

線上下見面時發生。

### 公平性原則

對於我請求他人做出的簽名，我會（按照對方的簽名策略）以相同級別簽署對方的金鑰。同時，我也希望從我所簽署的金鑰的持有者處獲得與我所作出的相同級別的簽名。

我希望對金鑰進行交叉簽名，所以若被簽署人並不願意簽署我的金鑰，則向我提出簽名請求不具有任何意義。

## Changelog

- 2021-08-16: 初稿
- 2022-02-20: 新增 MIT 和 Ubuntu 的公鑰伺服器
- 2022-02-24: 新增二維碼
- 2022-02-24: 僅作出 Level 2 和 3 等級的簽名
- 2022-03-13: 糾正拼寫錯誤
- 2022-03-13: 移除 keys.openpgp.org，因為它不會保留簽名
- 2022-03-13: 修正 Outvi V 的簽名方針連結
- 2022-03-13: 修正將作出的簽名等級

## 授權

Copyright (C) 2021-2022 Celeste Liu.

Permission is granted to copy, distribute and/or modify this document under the terms of the [GNU Free Documentation License](https://www.gnu.org/licenses/fdl.html), Version 1.3 or any later version published by the Free Software Foundation.

> A signed version of this documentation is available at:
> https://pgp.coelacanthus.moe/policy-signed.txt
