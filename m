Received: from eggs.gnu.org ([209.51.188.92]:52677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hGpC5-0006eQ-R4
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 14:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hGpC4-0001mU-Lx
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 14:22:01 -0400
Resent-Message-Id: <E1hGpC4-0001mU-Lx@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hGpC4-0001l7-2X
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 14:22:00 -0400
Message-ID: <155552529277.17102.9216298997846682613@76452e4e88f2>
In-Reply-To: <87mukov6vk.fsf@dusky.pond.sub.org>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 17 Apr 2019 11:21:33 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 14.5/15] char-pty: Print "char device
 redirected" message to stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: armbru@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS84N211a292NnZrLmZzZkBkdXNr
eS5wb25kLnN1Yi5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2FuIGJ1aWxk
IHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQg
YmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVw
cm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0LXNv
ZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQVIgICAgICBs
aWJxZW11dXRpbC5hCiAgTElOSyAgICBlbGYyZG1wCiAgQVMgICAgICBvcHRpb25yb20vbXVsdGli
b290Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL2NoYXJkZXYvY2hhci1wdHkuYzoyMTQ6NTogZXJyb3I6
IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdxZW11X3ByaW50ZicgaXMgaW52YWxp
ZCBpbiBDOTkgWy1XZXJyb3IsLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgIHFl
bXVfcHJpbnRmKCJjaGFyIGRldmljZSByZWRpcmVjdGVkIHRvICVzIChsYWJlbCAlcylcbiIsCiAg
ICBeCi90bXAvcWVtdS10ZXN0L3NyYy9jaGFyZGV2L2NoYXItcHR5LmM6MjE0OjU6IGVycm9yOiB0
aGlzIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIGlzIG5vdCBhIHByb3RvdHlwZSBbLVdlcnJvciwtV3N0
cmljdC1wcm90b3R5cGVzXQoyIGVycm9ycyBnZW5lcmF0ZWQuCiAgTElOSyAgICBpdnNobWVtLWNs
aWVudAogIExJTksgICAgaXZzaG1lbS1zZXJ2ZXIKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzg3bXVrb3Y2dmsuZnNmQGR1c2t5LnBvbmQuc3Vi
Lm9yZy90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
