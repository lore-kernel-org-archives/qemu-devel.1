Received: from eggs.gnu.org ([2001:4830:134:3::10]:52091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gUNzL-00040L-RX
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 22:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gUNzK-00054f-Bd
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 22:36:39 -0500
Resent-Message-Id: <E1gUNzK-00054f-Bd@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gUNzJ-00053K-Ut
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 22:36:38 -0500
In-Reply-To: <1543961939-2419-1-git-send-email-walling@linux.ibm.com>
Message-ID: <154396740385.19757.11762580412134936324@c26723477dc9>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 4 Dec 2018 15:50:05 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v1] s390: guest support for diagnose 318
 and limit max VCPUs to 247
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: walling@linux.ibm.com
Cc: famz@redhat.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, cotte@de.ibm.com, david@redhat.com, mimu@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTQzOTYxOTM5LTI0MTktMS1n
aXQtc2VuZC1lbWFpbC13YWxsaW5nQGxpbnV4LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpTdWJqZWN0OiBbUWVtdS1kZXZl
bF0gW1BBVENIIHYxXSBzMzkwOiBndWVzdCBzdXBwb3J0IGZvciBkaWFnbm9zZSAzMTggYW5kIGxp
bWl0IG1heCBWQ1BVcyB0byAyNDcKTWVzc2FnZS1pZDogMTU0Mzk2MTkzOS0yNDE5LTEtZ2l0LXNl
bmQtZW1haWwtd2FsbGluZ0BsaW51eC5pYm0uY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJB
U0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGlt
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0
PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJD
aGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4u
LiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2tw
YXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8K
ICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4
NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmI1MjE4YTcgczM5MDogZ3Vlc3Qgc3Vw
cG9ydCBmb3IgZGlhZ25vc2UgMzE4IGFuZCBsaW1pdCBtYXggVkNQVXMgdG8gMjQ3Cgo9PT0gT1VU
UFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAxLzE6IHMzOTA6IGd1ZXN0IHN1cHBvcnQgZm9y
IGRpYWdub3NlIDMxOCBhbmQgbGltaXQgbWF4IFZDUFVzIHRvIDI0Ny4uLgpFUlJPUjogYWRkaW5n
IGEgbGluZSB3aXRob3V0IG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKIzI0MzogRklMRTogdGFyZ2V0
L3MzOTB4L2RpYWcuYzoxODk6Cit9CgpFUlJPUjogYWRkaW5nIGEgbGluZSB3aXRob3V0IG5ld2xp
bmUgYXQgZW5kIG9mIGZpbGUKIzI5MjogRklMRTogdGFyZ2V0L3MzOTB4L2t2bS1zdHViLmM6MTE2
OgorfQoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAyNDcgbGluZXMgY2hlY2tlZAoKWW91
ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU0Mzk2MTkzOS0yNDE5LTEtZ2l0LXNlbmQt
ZW1haWwtd2FsbGluZ0BsaW51eC5pYm0uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t
