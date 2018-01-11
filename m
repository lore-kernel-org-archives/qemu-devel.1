Received: from eggs.gnu.org ([2001:4830:134:3::10]:53707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eZjei-0005fL-Pr
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eZjef-00024H-LH
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:40:56 -0500
Resent-Message-Id: <E1eZjef-00024H-LH@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eZjef-0001xU-Cz
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:40:53 -0500
In-Reply-To: <1515700960-26388-1-git-send-email-thuth@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151570319146.441.4052747471037245256@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 11 Jan 2018 12:39:52 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] net: Allow netdevs to be used with
 'hostfwd_add' and 'hostfwd_remove'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, jasowang@redhat.com, samuel.thibault@ens-lyon.org, dgilbert@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MTU3MDA5NjAtMjYzODgtMS1naXQtc2VuZC1lbWFpbC10aHV0aEByZWRoYXQu
Y29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIG5ldDogQWxsb3cgbmV0ZGV2cyB0byBi
ZSB1c2VkIHdpdGggJ2hvc3Rmd2RfYWRkJyBhbmQgJ2hvc3Rmd2RfcmVtb3ZlJwoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNlCm49MQp0b3RhbD0kKGdpdCBs
b2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAKCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVl
Cgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3Ig
YyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChn
aXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZv
cm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgog
ICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoK
ZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMy
MWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKY2M1OWM3ZDUxMCBuZXQ6IEFsbG93IG5ldGRldnMgdG8gYmUgdXNlZCB3aXRoICdob3N0
ZndkX2FkZCcgYW5kICdob3N0ZndkX3JlbW92ZScKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNr
aW5nIFBBVENIIDEvMTogbmV0OiBBbGxvdyBuZXRkZXZzIHRvIGJlIHVzZWQgd2l0aCAnaG9zdGZ3
ZF9hZGQnIGFuZCAnaG9zdGZ3ZF9yZW1vdmUnLi4uCkVSUk9SOiBjb25zaWRlciB1c2luZyBxZW11
X3N0cnRvbCBpbiBwcmVmZXJlbmNlIHRvIHN0cnRvbAojNzE6IEZJTEU6IG5ldC9zbGlycC5jOjQx
NDoKKyAgICAgICAgICAgIG5jID0gbmV0X2h1Yl9maW5kX2NsaWVudF9ieV9uYW1lKHN0cnRvbCho
dWJfaWQsIE5VTEwsIDApLCBuYW1lKTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNzMg
bGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09
IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0
cy5vcmc=
