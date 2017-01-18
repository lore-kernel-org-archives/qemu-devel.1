Received: from eggs.gnu.org ([2001:4830:134:3::10]:36539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cTlAs-0002jT-PL
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cTlAp-000146-Gi
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:00:54 -0500
Resent-Message-Id: <E1cTlAp-000146-Gi@eggs.gnu.org>
Received: from sender163-mail.zoho.com ([165.254.168.72]:21446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cTlAp-00011L-4x
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:00:51 -0500
In-Reply-To: <20161201052844.31819-1-bobby.prani@gmail.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148472643642.214.7504531151595764217@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 18 Jan 2017 00:00:37 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v5 0/3] Add litmus tests for MTTCG
 consistency tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bobby.prani@gmail.com
Cc: famz@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org, rth@twiddle.net

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NjEyMDEwNTI4NDQuMzE4MTktMS1ib2JieS5wcmFuaUBnbWFpbC5jb20KU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCB2NSAwLzNdIEFkZCBsaXRtdXMgdGVzdHMgZm9yIE1UVENHIGNvbnNpc3Rl
bmN5IHRlc3RzClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
YmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3
YyAtbCkKZmFpbGVkPTAKCiMgVXNlZnVsIGdpdCBvcHRpb25zCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpj
b21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBp
biAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQg
bG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1h
dD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAg
ICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhp
dCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZm
ODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CmZhdGFsOiB1bmFibGUgdG8gYWNjZXNzICdodHRw
czovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUvJzogRmFpbGVkIGNvbm5lY3QgdG8g
Z2l0aHViLmNvbTo0NDM7IE9wZXJhdGlvbiBub3cgaW4gcHJvZ3Jlc3MKZXJyb3I6IENvdWxkIG5v
dCBmZXRjaCAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClRyYWNlYmFj
ayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIvdXNyL2Jpbi9wYXRjaGV3IiwgbGlu
ZSA0MDYsIGluIHRlc3Rfb25lCiAgICBnaXRfY2xvbmVfcmVwbyhjbG9uZSwgclsicmVwbyJdLCBy
WyJoZWFkIl0sIGxvZ2YpCiAgRmlsZSAiL3Vzci9iaW4vcGF0Y2hldyIsIGxpbmUgNDcsIGluIGdp
dF9jbG9uZV9yZXBvCiAgICBzdGRvdXQ9bG9nZiwgc3RkZXJyPWxvZ2YpCiAgRmlsZSAiL3Vzci9s
aWI2NC9weXRob24zLjQvc3VicHJvY2Vzcy5weSIsIGxpbmUgNTYxLCBpbiBjaGVja19jYWxsCiAg
ICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxl
ZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydnaXQnLCAncmVtb3RlJywgJ2FkZCcsICctZicsICct
LW1pcnJvcj1mZXRjaCcsICczYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0
JywgJ2h0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdSddJyByZXR1cm5lZCBu
b24temVybyBleGl0IHN0YXR1cyAxCgoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
