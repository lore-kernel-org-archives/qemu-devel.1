Received: from eggs.gnu.org ([209.51.188.92]:37023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hBJBM-0005St-He
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hBJBL-0002MB-DJ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:10:28 -0400
Resent-Message-Id: <E1hBJBL-0002MB-DJ@eggs.gnu.org>
Message-ID: <155421055284.12882.5790881425394900302@76452e4e88f2>
In-Reply-To: <20190402121908.44081-1-slp@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 2 Apr 2019 06:09:14 -0700 (PDT)
Subject: Re: [Qemu-devel] [RFC PATCH] aio: Add a knob to always poll if
 there are in-flight requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: slp@redhat.com
Cc: fam@euphon.net, qemu-block@nongnu.org, kwolf@redhat.comfam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwMjEyMTkwOC40NDA4
MS0xLXNscEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5k
cyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5
b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3JhIFNI
T1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAg
ICB1dGlsL3FlbXUtc29ja2V0cy5vCiAgQ0MgICAgICB1dGlsL3VyaS5vCiAgQ0MgICAgICB1dGls
L25vdGlmeS5vCi90bXAvcWVtdS10ZXN0L3NyYy91dGlsL2Fpby13aW4zMi5jOjQwNjo2OiBlcnJv
cjogY29uZmxpY3RpbmcgdHlwZXMgZm9yICdhaW9fY29udGV4dF9zZXRfcG9sbF9wYXJhbXMnCiB2
b2lkIGFpb19jb250ZXh0X3NldF9wb2xsX3BhcmFtcyhBaW9Db250ZXh0ICpjdHgsIGludDY0X3Qg
bWF4X25zLAogICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KSW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2Jsb2NrL2Jsb2NrLmg6NCwKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNDAy
MTIxOTA4LjQ0MDgxLTEtc2xwQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3Jh
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
