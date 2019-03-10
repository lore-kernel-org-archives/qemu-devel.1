Received: from eggs.gnu.org ([209.51.188.92]:55869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h31fI-0003DV-1M
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 12:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1h31fG-0008L5-US
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 12:51:07 -0400
Resent-Message-Id: <E1h31fG-0008L5-US@eggs.gnu.org>
Message-ID: <155223663493.31099.11768542801492225686@6acff2cf482b>
In-Reply-To: <20190305234337.18353-1-jsnow@redhat.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 10 Mar 2019 09:50:36 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 0/5] block/qcow2-bitmap: Enable resize with
 persistent bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDMwNTIzNDMzNy4xODM1
My0xLWpzbm93QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEg
U0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAg
ICAgIGNyeXB0by90bHNzZXNzaW9uLm8KICBDQyAgICAgIGNyeXB0by9zZWNyZXQubwovdG1wL3Fl
bXUtdGVzdC9zcmMvYmxvY2svcWNvdzItYml0bWFwLmM6IEluIGZ1bmN0aW9uICdxY293Ml90cnVu
Y2F0ZV9iaXRtYXBzX2NoZWNrJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWJpdG1h
cC5jOjExOTg6MTM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnYmRy
dl9kaXJ0eV9iaXRtYXBfY2hlY2snOyBkaWQgeW91IG1lYW4gJ2JkcnZfZGlydHlfYml0bWFwX2xv
Y2snPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgICAgICAgaWYg
KGJkcnZfZGlydHlfYml0bWFwX2NoZWNrKGJpdG1hcCwgQkRSVl9CSVRNQVBfREVGQVVMVCwgZXJy
cCkpIHsKICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgICAgICAgICAgICBi
ZHJ2X2RpcnR5X2JpdG1hcF9sb2NrCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1iaXRt
YXAuYzoxMTk4OjEzOiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnYmRydl9k
aXJ0eV9iaXRtYXBfY2hlY2snIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQovdG1wL3FlbXUtdGVz
dC9zcmMvYmxvY2svcWNvdzItYml0bWFwLmM6MTE5ODo0NTogZXJyb3I6ICdCRFJWX0JJVE1BUF9E
RUZBVUxUJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3Ug
bWVhbiAnRE1fT1VUX0RFRkFVTFQnPwogICAgICAgICBpZiAoYmRydl9kaXJ0eV9iaXRtYXBfY2hl
Y2soYml0bWFwLCBCRFJWX0JJVE1BUF9ERUZBVUxULCBlcnJwKSkgewogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+CiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERNX09VVF9ERUZBVUxUCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDMw
NTIzNDMzNy4xODM1My0xLWpzbm93QHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVk
b3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=
