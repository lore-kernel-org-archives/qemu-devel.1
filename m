Received: from eggs.gnu.org ([2001:4830:134:3::10]:55266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fQUDw-0004TN-NB
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 04:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1fQUDt-0001pj-LN
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 04:55:20 -0400
Resent-Message-Id: <E1fQUDt-0001pj-LN@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1fQUDt-0001oS-7Y
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 04:55:17 -0400
In-Reply-To: <1528207243-268226-1-git-send-email-imammedo@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <152827530337.435.4960545261393922043@d39dc562802a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 6 Jun 2018 01:55:04 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v3 0/2] fix -nodefaults and -daemonize
 regressions caused by --preconfig introduction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, ldoktor@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, mreitz@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MjgyMDcyNDMtMjY4MjI2LTEtZ2l0LXNlbmQtZW1haWwtaW1hbW1lZG9AcmVk
aGF0LmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYzIDAvMl0gZml4IC1ub2RlZmF1
bHRzIGFuZCAtZGFlbW9uaXplIHJlZ3Jlc3Npb25zIGNhdXNlZCBieSAtLXByZWNvbmZpZyBpbnRy
b2R1Y3Rpb24KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFz
ZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0w
CgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4p
Igpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3Rh
bDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAk
YyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsg
dGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkK
ZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhj
ZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJy
YW5jaCAndGVzdCcKMDEzNzMyOTFiMiB2bDogZml4IHVzZSBvZiAtLWRhZW1vbml6ZSB3aXRoIC0t
cHJlY29uZmlnCmI2ZjMyNTM1N2QgY2xpOiBEb24ndCBydW4gZWFybHkgZXZlbnQgbG9vcCBpZiBu
byAtLXByZWNvbmZpZyB3YXMgc3BlY2lmaWVkCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2lu
ZyBQQVRDSCAxLzI6IGNsaTogRG9uJ3QgcnVuIGVhcmx5IGV2ZW50IGxvb3AgaWYgbm8gLS1wcmVj
b25maWcgd2FzIHNwZWNpZmllZC4uLgpDaGVja2luZyBQQVRDSCAyLzI6IHZsOiBmaXggdXNlIG9m
IC0tZGFlbW9uaXplIHdpdGggLS1wcmVjb25maWcuLi4KRVJST1I6IGRvIG5vdCBpbml0aWFsaXNl
IHN0YXRpY3MgdG8gMCBvciBOVUxMCiM0NDogRklMRTogb3MtcG9zaXguYzozMTI6CisgICAgc3Rh
dGljIGJvb2wgb3Nfc2V0dXBfcG9zdF9kb25lID0gZmFsc2U7Cgp0b3RhbDogMSBlcnJvcnMsIDAg
d2FybmluZ3MsIDI4IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1z
LCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRp
dmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlO
VEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNv
ZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t
