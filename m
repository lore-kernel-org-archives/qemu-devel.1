Received: from eggs.gnu.org ([209.51.188.92]:36210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG1Ab-0001XG-Kt
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG1AZ-0000HO-Vk
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:57:09 -0400
Resent-Message-Id: <E1hG1AZ-0000HO-Vk@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hG1AW-0000Dw-Dn
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:57:05 -0400
Message-ID: <155533026233.29694.9877995192838414039@76452e4e88f2>
In-Reply-To: <20190415113431.12060-1-berrange@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Mon, 15 Apr 2019 05:11:03 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] vl: set LC_MESSAGES and LC_CTYPE in main
 for all code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, armbru@redhat.com, bsd@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, samuel.thibault@ens-lyon.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxNTExMzQzMS4xMjA2
MC0xLWJlcnJhbmdlQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRv
cmEgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBD
QyAgICAgIGh3L2kyYy92ZXJzYXRpbGVfaTJjLm8KICBDQyAgICAgIGh3L2kyYy9zbWJ1c19pY2g5
Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL3ZsLmM6IEluIGZ1bmN0aW9uICdxZW11X21haW4nOgovdG1w
L3FlbXUtdGVzdC9zcmMvdmwuYzozMDU4OjE1OiBlcnJvcjogJ0xDX01FU1NBR0VTJyB1bmRlY2xh
cmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiAnTENTX0dNX0lN
QUdFUyc/CiAgICAgc2V0bG9jYWxlKExDX01FU1NBR0VTLCAiIik7CiAgICAgICAgICAgICAgIF5+
fn5+fn5+fn5+CiAgICAgICAgICAgICAgIExDU19HTV9JTUFHRVMKCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNDE1MTEzNDMxLjEyMDYw
LTEtYmVycmFuZ2VAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=
