Received: from eggs.gnu.org ([209.51.188.92]:53032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gmIWl-00029r-7N
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gmIQW-00016N-63
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:18:45 -0500
Resent-Message-Id: <E1gmIQW-00016N-63@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gmIQV-000142-SB
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 08:18:44 -0500
Message-ID: <154824947630.21.17602979898863801646@ebba9967afc0>
In-Reply-To: <1546533252-26601-1-git-send-email-aleksandar.markovic@rt-rk.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 23 Jan 2019 05:17:57 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH 0/8] target/mips: Update Inter-Thread
 Communication Unit support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aleksandar.markovic@rt-rk.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, smarkovic@wavecomp.com, arikalo@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTQ2NTMzMjUyLTI2NjAxLTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFz
ZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlv
dSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0Cmxv
Y2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBk
b2NrZXItdGVzdC1taW5nd0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0Cj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgogIENDICAgICAgY3J5cHRvL2hhc2gubwogIENDICAgICAgY3J5cHRvL2hhc2gtbmV0
dGxlLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3NoZWVwZG9nLmM6IEluIGZ1bmN0aW9uICdm
aW5kX3ZkaV9uYW1lJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3NoZWVwZG9nLmM6MTIzOTo1
OiBlcnJvcjogJ3N0cm5jcHknIHNwZWNpZmllZCBib3VuZCAyNTYgZXF1YWxzIGRlc3RpbmF0aW9u
IHNpemUgWy1XZXJyb3I9c3RyaW5nb3AtdHJ1bmNhdGlvbl0KICAgICBzdHJuY3B5KGJ1ZiArIFNE
X01BWF9WRElfTEVOLCB0YWcsIFNEX01BWF9WRElfVEFHX0xFTik7CiAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5p
bmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTQ2NTMzMjUyLTI2NjAxLTEtZ2l0LXNlbmQtZW1h
aWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVk
b3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
