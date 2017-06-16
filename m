Received: from eggs.gnu.org ([2001:4830:134:3::10]:46535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dLn2q-0003db-3a
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 04:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dLn2m-000504-UN
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 04:55:56 -0400
Resent-Message-Id: <E1dLn2m-000504-UN@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1dLn2m-0004yY-H5
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 04:55:52 -0400
In-Reply-To: <20170616051526.6814-1-rth@twiddle.net>
Message-ID: <149760332783.7905.13849093882410453512@4a9a010726c0>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 16 Jun 2017 01:55:28 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x: Enforce instruction
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net
Cc: famz@redhat.com, qemu-devel@nongnu.org, thuth@redhat.com, aurelien@aurel32.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTcwNjE2MDUxNTI2LjY4MTQtMS1ydGhAdHdpZGRsZS5uZXQKU3ViamVjdDog
W1FlbXUtZGV2ZWxdIFtQQVRDSCB2Ml0gdGFyZ2V0L3MzOTB4OiBFbmZvcmNlIGluc3RydWN0aW9u
IGZlYXR1cmVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJh
c2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9
MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJl
dmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcg
UEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBp
ZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQog
ICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
ClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNo
ZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwphMjEzMWZkIHRhcmdldC9zMzkweDogRW5mb3JjZSBp
bnN0cnVjdGlvbiBmZWF0dXJlcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0gg
MS8xOiB0YXJnZXQvczM5MHg6IEVuZm9yY2UgaW5zdHJ1Y3Rpb24gZmVhdHVyZXMuLi4KRVJST1I6
IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMzMDogRklMRTogdGFyZ2V0L3MzOTB4L2NwdV9mZWF0
dXJlcy5jOjI1NToKKyAgICBGRUFUX0lOSVQoInRjZy1hbGwtaW5zbnMiLCBTMzkwX0ZFQVRfVFlQ
RV9NSVNDLCAwLCAiRW5hYmxlIGFsbCBpbnNucyBzdXBwb3J0ZWQgYnkgVENHIiksCgp0b3RhbDog
MSBlcnJvcnMsIDAgd2FybmluZ3MsIDYxIGxpbmVzIGNoZWNrZWQKCllvdXIgcGF0Y2ggaGFzIHN0
eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQ
QVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4
aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
