Received: from eggs.gnu.org ([2001:4830:134:3::10]:51103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dPriq-0001v5-1Q
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dPrin-00028B-Eu
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:44:08 -0400
Resent-Message-Id: <E1dPrin-00028B-Eu@eggs.gnu.org>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <149857461892.29731.17688834718600195927@lemon.lan>
In-Reply-To: <20170626123510.20134-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 27 Jun 2017 07:43:43 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v6 0/5] Improve I/O tests coverage of LUKS
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAx
NzA2MjYxMjM1MTAuMjAxMzQtMS1iZXJyYW5nZUByZWRoYXQuY29tClR5cGU6IHNlcmllcwpTdWJq
ZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY2IDAvNV0gSW1wcm92ZSBJL08gdGVzdHMgY292ZXJh
Z2Ugb2YgTFVLUyBkcml2ZXIKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gK
CkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwp
CmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0
PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJD
aGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4u
LiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2tw
YXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8K
ICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4
NApUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi9wYXRjaGV3LWNs
aSIsIGxpbmUgNDMwLCBpbiB0ZXN0X29uZQogICAgZ2l0X2Nsb25lX3JlcG8oY2xvbmUsIHJbInJl
cG8iXSwgclsiaGVhZCJdLCBsb2dmKQogIEZpbGUgIi4vcGF0Y2hldy1jbGkiLCBsaW5lIDQ4LCBp
biBnaXRfY2xvbmVfcmVwbwogICAgc3Rkb3V0PWxvZ2YsIHN0ZGVycj1sb2dmKQogIEZpbGUgIi91
c3IvbGliNjQvcHl0aG9uMy41L3N1YnByb2Nlc3MucHkiLCBsaW5lIDI2NiwgaW4gY2hlY2tfY2Fs
bAogICAgcmV0Y29kZSA9IGNhbGwoKnBvcGVuYXJncywgKiprd2FyZ3MpCiAgRmlsZSAiL3Vzci9s
aWI2NC9weXRob24zLjUvc3VicHJvY2Vzcy5weSIsIGxpbmUgMjQ5LCBpbiBjYWxsCiAgICByZXR1
cm4gcC53YWl0KHRpbWVvdXQ9dGltZW91dCkKICBGaWxlICIvdXNyL2xpYjY0L3B5dGhvbjMuNS9z
dWJwcm9jZXNzLnB5IiwgbGluZSAxMzg5LCBpbiB3YWl0CiAgICAocGlkLCBzdHMpID0gc2VsZi5f
dHJ5X3dhaXQoMCkKICBGaWxlICIvdXNyL2xpYjY0L3B5dGhvbjMuNS9zdWJwcm9jZXNzLnB5Iiwg
bGluZSAxMzM5LCBpbiBfdHJ5X3dhaXQKICAgIChwaWQsIHN0cykgPSBvcy53YWl0cGlkKHNlbGYu
cGlkLCB3YWl0X2ZsYWdzKQpLZXlib2FyZEludGVycnVwdAoKCgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
