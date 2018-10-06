Received: from eggs.gnu.org ([2001:4830:134:3::10]:45690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ndragazis@outlook.com.gr>) id 1g8snT-0001XD-9E
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 16:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ndragazis@outlook.com.gr>) id 1g8snO-0004SL-Cq
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 16:03:31 -0400
Received: from mail-db5eur01lp0179.outbound.protection.outlook.com
	([213.199.154.179]:30792
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ndragazis@outlook.com.gr>)
	id 1g8snM-0004Pl-Ni
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 16:03:26 -0400
From: Nikos Dragazis <ndragazis@outlook.com.gr>
Date: Sat, 6 Oct 2018 20:03:22 +0000
Message-ID: <DB7PR07MB3867468812F702134BC2BCAC98E40@DB7PR07MB3867.eurprd07.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DA9C3338CF5994283386AC6FFFEF6AB@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] vhost: add virtio-vhost-user transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "spdk@lists.01.org" <spdk@lists.01.org>
Cc: Vangelis Koukis <vkoukis@arrikto.com>, Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

SGkgZXZlcnlvbmUsDQoNCkluIHJlc3BvbnNlIHRvIGEgcHJldmlvdXMgZW1haWwgb2YgbWluZSBo
ZXJlOg0KDQpodHRwczovL2xpc3RzLjAxLm9yZy9waXBlcm1haWwvc3Bkay8yMDE4LVNlcHRlbWJl
ci8wMDI0ODguaHRtbA0KDQpJIHdvdWxkIGxpa2UgdG8gc2hhcmUgdGhhdCBJIGhhdmUgYWRkZWQg
c3VwcG9ydCBmb3IgYSBuZXcNCnZpcnRpby12aG9zdC11c2VyIHRyYW5zcG9ydCB0byBTUERLLiBh
bmQgaGF2ZSBhIHdvcmtpbmcgZGVtbyBvZiB0aGUgU1BESw0Kdmhvc3Qtc2NzaSB0YXJnZXQgb3Zl
ciB0aGlzIHRyYW5zcG9ydC4gSSBoYXZlIHRlc3RlZCBpdCBzdWNjZXNzZnVsbHkNCndpdGggTWFs
bG9jIGJkZXYsIE5WTWUgYmRldiBhbmQgdmlydGlvLXNjc2kgYmRldi4NCg0KTXkgY29kZSBjdXJy
ZW50bHkgbGl2ZXMgaGVyZToNCg0KaHR0cHM6Ly9naXRodWIuY29tL25kcmFnYXppcy9zcGRrDQoN
CkknZCBsb3ZlIHRvIGdldCB5b3VyIGZlZWRiYWNrIGFuZCBoYXZlIGl0IG1lcmdlZCBldmVudHVh
bGx5LiBJIHNlZSB0aGVyZQ0KaXMgYSByZWxldmFudCBjb252ZXJzYXRpb24gb24gdGhpcyB0b3Bp
YyBoZXJlOg0KDQpodHRwczovL2xpc3RzLjAxLm9yZy9waXBlcm1haWwvc3Bkay8yMDE4LU1hcmNo
LzAwMTU1Ny5odG1sDQoNCklzIHRoZXJlIGFueW9uZSBpbiB0aGlzIGNvbW11bml0eSBjdXJyZW50
bHkgd29ya2luZyBvbiB0aGlzPyBXaGF0IHdvdWxkDQpteSBuZXh0IHN0ZXAgaW4gY29udHJpYnV0
aW5nIHRoaXMgYmU/DQoNCkxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIGZlZWRiYWNrLA0KTmlrb3MN
Cg0KLS0NCk5pa29zIERyYWdhemlzDQpVbmRlcmdyYWR1YXRlIFN0dWRlbnQNClNjaG9vbCBvZiBF
bGVjdHJpY2FsIGFuZCBDb21wdXRlciBFbmdpbmVlcmluZw0KTmF0aW9uYWwgVGVjaG5pY2FsIFVu
aXZlcnNpdHkgb2YgQXRoZW5zDQoNCg==
