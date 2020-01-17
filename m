Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669B9C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390D62072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390D62072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUrj-0002Qg-E1
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1isUlY-0005Bw-8j
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1isUlU-0004bC-Fu
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:46:35 -0500
Resent-Date: Fri, 17 Jan 2020 11:46:35 -0500
Resent-Message-Id: <E1isUlU-0004bC-Fu@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1isUlU-0004YC-81
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:46:32 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1579279580013783.2055555033722;
 Fri, 17 Jan 2020 08:46:20 -0800 (PST)
In-Reply-To: <20200117110758.1995-1-thuth@redhat.com>
Subject: Re: [PULL 0/4] qtests and gitlab-CI
Message-ID: <157927957887.5569.10481248275615880712@197193fa8d23>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Fri, 17 Jan 2020 08:46:20 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDExNzExMDc1OC4xOTk1
LTEtdGh1dGhAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDAxMTcxMTA3NTguMTk5NS0xLXRodXRoQHJlZGhhdC5j
b20KVHlwZTogc2VyaWVzClN1YmplY3Q6IFtQVUxMIDAvNF0gcXRlc3RzIGFuZCBnaXRsYWItQ0kK
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNl
ID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIw
MjAwMTE3MTEwNzU4LjE5OTUtMS10aHV0aEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDAxMTcx
MTA3NTguMTk5NS0xLXRodXRoQHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0
ZXN0Jwo3ZmJiYWY3IGdpdGxhYi1jaS55bWw6IFJ1biB0Y2cgdGVzdCB3aXRoIHRjaQoxYzRkMTA0
IHRlc3RzL3F0ZXN0L3Zob3N0LXVzZXItdGVzdDogRml4IG1lbW9yeSBsZWFrcwoyZTE3MjhjIG1p
Z3JhdGlvbi10ZXN0OiBwcGM2NDogZml4IEZPUlRIIHRlc3QgcHJvZ3JhbQoyNDdhNmEwIHRlc3Rz
OiBhY3BpOiB1cGRhdGUgcGF0aCBpbiByZWJ1aWxkLWV4cGVjdGVkLWFtbAoKPT09IE9VVFBVVCBC
RUdJTiA9PT0KMS80IENoZWNraW5nIGNvbW1pdCAyNDdhNmEwMzM5MzcgKHRlc3RzOiBhY3BpOiB1
cGRhdGUgcGF0aCBpbiByZWJ1aWxkLWV4cGVjdGVkLWFtbCkKRVJST1I6IGxpbmUgb3ZlciA5MCBj
aGFyYWN0ZXJzCiM0NDogRklMRTogdGVzdHMvZGF0YS9hY3BpL3JlYnVpbGQtZXhwZWN0ZWQtYW1s
LnNoOjM0OgorZWNobyAnLyogTGlzdCBvZiBjb21tYS1zZXBhcmF0ZWQgY2hhbmdlZCBBTUwgZmls
ZXMgdG8gaWdub3JlICovJyA+ICR7U1JDX1BBVEh9L3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRl
c3QtYWxsb3dlZC1kaWZmLmgKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMjEgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggMS80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzQgQ2hlY2tp
bmcgY29tbWl0IDJlMTcyOGMzNGYyYiAobWlncmF0aW9uLXRlc3Q6IHBwYzY0OiBmaXggRk9SVEgg
dGVzdCBwcm9ncmFtKQozLzQgQ2hlY2tpbmcgY29tbWl0IDFjNGQxMDQ5N2U2OSAodGVzdHMvcXRl
c3Qvdmhvc3QtdXNlci10ZXN0OiBGaXggbWVtb3J5IGxlYWtzKQo0LzQgQ2hlY2tpbmcgY29tbWl0
IDdmYmJhZjdhMGRmNiAoZ2l0bGFiLWNpLnltbDogUnVuIHRjZyB0ZXN0IHdpdGggdGNpKQo9PT0g
T1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDExNzEx
MDc1OC4xOTk1LTEtdGh1dGhAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=


