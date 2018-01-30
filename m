Received: from eggs.gnu.org ([2001:4830:134:3::10]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1egUeT-0007Un-LK
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1egUeK-0003zl-5d
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:04:37 -0500
Resent-Message-Id: <E1egUeK-0003zl-5d@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1egUeJ-0003zL-SE
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:04:28 -0500
In-Reply-To: <20180130035527.47336-1-aik@ozlabs.ru>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151728588035.800.15328948644533230574@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 29 Jan 2018 20:18:01 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH qemu v5 0/2] vfio-pci: Allow mmap of MSIX
 BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aik@ozlabs.ru
Cc: famz@redhat.com, qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMTMwMDM1NTI3LjQ3MzM2LTEtYWlrQG96bGFicy5ydQpTdWJqZWN0OiBb
UWVtdS1kZXZlbF0gW1BBVENIIHFlbXUgdjUgMC8yXSB2ZmlvLXBjaTogQWxsb3cgbW1hcCBvZiBN
U0lYIEJBUgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFTRT1iYXNl
Cm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFpbGVkPTAK
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIkKGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZl
cnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBB
VENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEgLS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYg
ISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxlZD0xCiAgICAgICAgZWNobwogICAgZmkKICAg
IG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVkCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpV
cGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVk
IHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMjYxYjRhMTMyNyBSRkM6IHZmaW8tcGNpOiBBbGxvdyBt
bWFwIG9mIE1TSVggQkFSCmVmZDQ0NzczNmMgdmZpby9jb21tb246IEFkZCAncDJwJyBwcm9wZXJ0
eSB0byBlbmFibGUgRE1BIG1hcHBpbmcgb2YgTU1JTyByZWdpb25zCgo9PT0gT1VUUFVUIEJFR0lO
ID09PQpDaGVja2luZyBQQVRDSCAxLzI6IHZmaW8vY29tbW9uOiBBZGQgJ3AycCcgcHJvcGVydHkg
dG8gZW5hYmxlIERNQSBtYXBwaW5nIG9mIE1NSU8gcmVnaW9ucy4uLgpFUlJPUjogbGluZSBvdmVy
IDkwIGNoYXJhY3RlcnMKIzU5OiBGSUxFOiBody92ZmlvL2NvbW1vbi5jOjUyMzoKKyAgICAgICAg
ICAgIGVycm9yX3JlcG9ydCgiUmVnaW9uICUiSFdBRERSX1BSSXgiLi4lIkhXQUREUl9QUkl4IiBp
cyBub3QgYWxpZ25lZCB0byAlIkhXQUREUl9QUkl4IiBhbmQgY2Fubm90IGJlIG1hcHBlZCBmb3Ig
RE1BIiwKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTA1IGxpbmVzIGNoZWNrZWQKCllv
dXIgcGF0Y2ggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCkNoZWNraW5nIFBBVENIIDIvMjog
UkZDOiB2ZmlvLXBjaTogQWxsb3cgbW1hcCBvZiBNU0lYIEJBUi4uLgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
