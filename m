Received: from eggs.gnu.org ([2001:4830:134:3::10]:38979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gaxHs-0000DR-66
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 01:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gaxHp-0003Bj-1y
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 01:30:56 -0500
Resent-Message-Id: <E1gaxHp-0003Bj-1y@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gaxHo-0003BH-PU
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 01:30:53 -0500
In-Reply-To: <1544796678-12736-1-git-send-email-pmorel@linux.ibm.com>
Message-ID: <154554569501.18047.4046339445177986571@02a1dbf831e2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sat, 22 Dec 2018 22:14:56 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v3] s390x/pci: add common function
 measurement block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pmorel@linux.ibm.com
Cc: fam@euphon.net, walling@linux.ibm.com, thuth@redhat.com, david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTQ0Nzk2Njc4LTEyNzM2LTEt
Z2l0LXNlbmQtZW1haWwtcG1vcmVsQGxpbnV4LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDE1NDQ3OTY2NzgtMTI3MzYtMS1n
aXQtc2VuZC1lbWFpbC1wbW9yZWxAbGludXguaWJtLmNvbQpUeXBlOiBzZXJpZXMKU3ViamVjdDog
W1FlbXUtZGV2ZWxdIFtQQVRDSCB2M10gczM5MHgvcGNpOiBhZGQgY29tbW9uIGZ1bmN0aW9uIG1l
YXN1cmVtZW50IGJsb2NrCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpC
QVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpm
YWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAk
QkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAk
bi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0
IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxi
YWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQo
KG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRp
bmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBh
IG5ldyBicmFuY2ggJ3Rlc3QnCjM2NjQ1ODQgczM5MHgvcGNpOiBhZGQgY29tbW9uIGZ1bmN0aW9u
IG1lYXN1cmVtZW50IGJsb2NrCgo9PT0gT1VUUFVUIEJFR0lOID09PQpDaGVja2luZyBQQVRDSCAx
LzE6IHMzOTB4L3BjaTogYWRkIGNvbW1vbiBmdW5jdGlvbiBtZWFzdXJlbWVudCBibG9jay4uLgpF
UlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM4MDogRklMRTogaHcvczM5
MHgvczM5MC1wY2ktYnVzLmg6MzA0OgorI2RlZmluZSBaUENJX0ZNQl9GT1JNQVReSTAkCgpFUlJP
UjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMyMTM6IEZJTEU6IGh3L3MzOTB4
L3MzOTAtcGNpLWluc3QuYzo5NTA6CiteSXJldCA9IE1FTVRYX0VSUk9SOyQKCldBUk5JTkc6IGxp
bmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyNDE6IEZJTEU6IGh3L3MzOTB4L3MzOTAtcGNpLWluc3Qu
Yzo5Nzg6CisgICAgaWYgKGZtYl9kb191cGRhdGUocGJkZXYsIG9mZnNldCwgcGJkZXYtPmZtYi5z
YW1wbGUrKywgc2l6ZW9mKHBiZGV2LT5mbWIuc2FtcGxlKSkpIHsKCnRvdGFsOiAyIGVycm9ycywg
MSB3YXJuaW5ncywgMjU3IGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0eWxlIHByb2Js
ZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9z
aXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBN
QUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRo
IGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzE1NDQ3OTY2NzgtMTI3MzYtMS1naXQtc2VuZC1lbWFpbC1wbW9yZWxAbGludXguaWJt
LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==
