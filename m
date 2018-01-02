Received: from eggs.gnu.org ([2001:4830:134:3::10]:34248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eWFTw-0004b2-Sz
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 00:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eWFTt-0005CX-36
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 00:51:24 -0500
Resent-Message-Id: <E1eWFTt-0005CX-36@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eWFTs-0005CM-Ra
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 00:51:21 -0500
In-Reply-To: <20180102052805.20498-1-aik@ozlabs.ru>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151487223746.156.10590326361851892533@5adcb62bf0d6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 1 Jan 2018 21:50:38 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH qemu 0/3] spapr/iommu: Enable in-kernel TCE
 acceleration via VFIO KVM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aik@ozlabs.ru
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, alex.williamson@redhat.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTgwMTAyMDUyODA1LjIwNDk4LTEtYWlrQG96bGFicy5ydQpTdWJqZWN0OiBb
UWVtdS1kZXZlbF0gW1BBVENIIHFlbXUgMC8zXSBzcGFwci9pb21tdTogRW5hYmxlIGluLWtlcm5l
bCBUQ0UgYWNjZWxlcmF0aW9uIHZpYSBWRklPIEtWTSBkZXZpY2UKCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25l
bGluZSAkQkFTRS4uIHwgd2MgLWwpCmZhaWxlZD0wCgpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQoKY29tbWl0
cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNv
bW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAt
biAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1h
aWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBm
YWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZh
aWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIx
NjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjMz
MjY5MzBkOTkgc3BhcHIvaW9tbXU6IEVuYWJsZSBpbi1rZXJuZWwgVENFIGFjY2VsZXJhdGlvbiB2
aWEgVkZJTyBLVk0gZGV2aWNlCmYzY2QwYzgxYjggdmZpby9zcGFwcjogVXNlIGlvbW11IG1lbW9y
eSByZWdpb24ncyBnZXRfYXR0cigpCjY3OTBmNDQxNGUgbWVtb3J5L2lvbW11OiBBZGQgZ2V0X2F0
dHIoKQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS8zOiBtZW1vcnkvaW9t
bXU6IEFkZCBnZXRfYXR0cigpLi4uCkNoZWNraW5nIFBBVENIIDIvMzogdmZpby9zcGFwcjogVXNl
IGlvbW11IG1lbW9yeSByZWdpb24ncyBnZXRfYXR0cigpLi4uCkVSUk9SOiBsaW5lIG92ZXIgOTAg
Y2hhcmFjdGVycwojNDY6IEZJTEU6IGh3L3ZmaW8vY29tbW9uLmM6NDc2OgorICAgICAgICAgICAg
ICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJ2ZmlvOiBmYWlsZWQgdG8gc2V0dXAgZmQgJWQgZm9y
IGEgZ3JvdXAgd2l0aCBmZCAlZDogJXMiLAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAz
NiBsaW5lcyBjaGVja2VkCgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgpD
aGVja2luZyBQQVRDSCAzLzM6IHNwYXByL2lvbW11OiBFbmFibGUgaW4ta2VybmVsIFRDRSBhY2Nl
bGVyYXRpb24gdmlhIFZGSU8gS1ZNIGRldmljZS4uLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
