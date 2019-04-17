Received: from eggs.gnu.org ([209.51.188.92]:52398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hGdJG-0001D4-4D
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hGdJC-0000Wm-BH
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:40:36 -0400
Resent-Message-Id: <E1hGdJC-0000Wm-BH@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hGdJ7-0000DF-OP
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 01:40:32 -0400
Message-ID: <155547960277.17102.1916370280246281593@76452e4e88f2>
In-Reply-To: <20190417053225.27505-1-richard.henderson@linaro.org>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 16 Apr 2019 22:40:03 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 0/1] util/path: Do not cache all filenames
 at startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: fam@euphon.net, qemu-devel@nongnu.org, peter.maydell@linaro.org, laurent@vivier.eu, evgreen@chromium.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxNzA1MzIyNS4yNzUw
NS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1t
aW5nd0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKICBDQyAgICAgIHJlcGxpY2F0aW9uLm8KICBDQyAgICAgIGJsb2NrL3Jhdy1mb3JtYXQu
bwovdG1wL3FlbXUtdGVzdC9zcmMvdXRpbC9wYXRoLmM6IEluIGZ1bmN0aW9uICdpbml0X3BhdGhz
JzoKL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvcGF0aC5jOjI0OjU6IGVycm9yOiAnZ19jYW5vbmlj
YWxpemVfZmlsZW5hbWUnIGlzIGRlcHJlY2F0ZWQ6IE5vdCBhdmFpbGFibGUgYmVmb3JlIDIuNTgg
Wy1XZXJyb3I9ZGVwcmVjYXRlZC1kZWNsYXJhdGlvbnNdCiAgICAgYmFzZSA9IGdfY2Fub25pY2Fs
aXplX2ZpbGVuYW1lKHByZWZpeCwgTlVMTCk7CiAgICAgXn5+fgpJbiBmaWxlIGluY2x1ZGVkIGZy
b20gL3Vzci94ODZfNjQtdzY0LW1pbmd3MzIvc3lzLXJvb3QvbWluZ3cvaW5jbHVkZS9nbGliLTIu
MC9nbGliLmg6NDgsCi0tLQogZ2NoYXIgKmdfY2Fub25pY2FsaXplX2ZpbGVuYW1lIChjb25zdCBn
Y2hhciAqZmlsZW5hbWUsCiAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11
LXRlc3Qvc3JjL3V0aWwvcGF0aC5jOiBJbiBmdW5jdGlvbiAncGF0aCc6Ci90bXAvcWVtdS10ZXN0
L3NyYy91dGlsL3BhdGguYzo1NDoxMzogZXJyb3I6IGFzc2lnbm1lbnQgZGlzY2FyZHMgJ2NvbnN0
JyBxdWFsaWZpZXIgZnJvbSBwb2ludGVyIHRhcmdldCB0eXBlIFstV2Vycm9yPWRpc2NhcmRlZC1x
dWFsaWZpZXJzXQogICAgICAgICByZXQgPSB2YWx1ZSA/IHZhbHVlIDogbmFtZTsKICAgICAgICAg
ICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvcGF0aC5jOjYwOjk6IGVycm9yOiAnZ19jYW5v
bmljYWxpemVfZmlsZW5hbWUnIGlzIGRlcHJlY2F0ZWQ6IE5vdCBhdmFpbGFibGUgYmVmb3JlIDIu
NTggWy1XZXJyb3I9ZGVwcmVjYXRlZC1kZWNsYXJhdGlvbnNdCiAgICAgICAgIGZ1bGxfbmFtZSA9
IGdfY2Fub25pY2FsaXplX2ZpbGVuYW1lKGdfcGF0aF9za2lwX3Jvb3QobmFtZSksIGJhc2UpOwog
ICAgICAgICBefn5+fn5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IveDg2XzY0LXc2NC1t
aW5ndzMyL3N5cy1yb290L21pbmd3L2luY2x1ZGUvZ2xpYi0yLjAvZ2xpYi5oOjQ4LAotLS0KL3Vz
ci94ODZfNjQtdzY0LW1pbmd3MzIvc3lzLXJvb3QvbWluZ3cvaW5jbHVkZS9nbGliLTIuMC9nbGli
L2dmaWxldXRpbHMuaDoxNzY6ODogbm90ZTogZGVjbGFyZWQgaGVyZQogZ2NoYXIgKmdfY2Fub25p
Y2FsaXplX2ZpbGVuYW1lIChjb25zdCBnY2hhciAqZmlsZW5hbWUsCiAgICAgICAgXn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvcGF0aC5jOjc0OjE3OiBlcnJv
cjogYXNzaWdubWVudCBkaXNjYXJkcyAnY29uc3QnIHF1YWxpZmllciBmcm9tIHBvaW50ZXIgdGFy
Z2V0IHR5cGUgWy1XZXJyb3I9ZGlzY2FyZGVkLXF1YWxpZmllcnNdCiAgICAgICAgICAgICByZXQg
PSBuYW1lOwogICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRl
ZCBhcyBlcnJvcnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMTkwNDE3MDUzMjI1LjI3NTA1LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJv
Lm9yZy90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
