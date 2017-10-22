Received: from eggs.gnu.org ([2001:4830:134:3::10]:38279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e6IYP-00026G-I0
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 11:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e6IYL-0005Gy-8l
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 11:52:45 -0400
Resent-Message-Id: <E1e6IYL-0005Gy-8l@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e6IYL-0005Cr-2I
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 11:52:41 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150868113318.482.11705826106714639873@b58463cdfd5f>
In-Reply-To: <1508678882-4327-1-git-send-email-sundeep.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 22 Oct 2017 07:05:34 -0700 (PDT)
Subject: Re: [Qemu-devel] [Qemu devel v3 PATCH] msf2: Remove dead code
 reported by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sundeep.lkml@gmail.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, crosthwaite.peter@gmail.com, f4bug@amsat.org, alistair23@gmail.com, darren.kenny@oracle.com, pbonzini@redhat.com, imammedo@redhat.com

SGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYXV0b21hdGljIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5k
IHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZl
IGRvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHku
CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMTUwODY3ODg4Mi00MzI3LTEtZ2l0LXNlbmQtZW1h
aWwtc3VuZGVlcC5sa21sQGdtYWlsLmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1FlbXUgZGV2
ZWwgdjMgUEFUQ0hdIG1zZjI6IFJlbW92ZSBkZWFkIGNvZGUgcmVwb3J0ZWQgYnkgQ292ZXJpdHkK
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKc2V0IC1lCmdpdCBzdWJtb2R1
bGUgdXBkYXRlIC0taW5pdCBkdGMKIyBMZXQgZG9ja2VyIHRlc3RzIGR1bXAgZW52aXJvbm1lbnQg
aW5mbwpleHBvcnQgU0hPV19FTlY9MQpleHBvcnQgSj04CnRpbWUgbWFrZSBkb2NrZXItdGVzdC1x
dWlja0BjZW50b3M2CnRpbWUgbWFrZSBkb2NrZXItdGVzdC1idWlsZEBtaW4tZ2xpYgp0aW1lIG1h
a2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3JhCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1ibG9ja0Bm
ZWRvcmEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8xNTA4Njc4ODgy
LTQzMjctMS1naXQtc2VuZC1lbWFpbC1zdW5kZWVwLmxrbWxAZ21haWwuY29tIC0+IHBhdGNoZXcv
MTUwODY3ODg4Mi00MzI3LTEtZ2l0LXNlbmQtZW1haWwtc3VuZGVlcC5sa21sQGdtYWlsLmNvbQpT
d2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmExYzY2YjY2ZTcgbXNmMjogUmVtb3ZlIGRl
YWQgY29kZSByZXBvcnRlZCBieSBDb3Zlcml0eQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KU3VibW9k
dWxlICdkdGMnIChnaXQ6Ly9naXQucWVtdS1wcm9qZWN0Lm9yZy9kdGMuZ2l0KSByZWdpc3RlcmVk
IGZvciBwYXRoICdkdGMnCkNsb25pbmcgaW50byAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LWVndWJhYW9jL3NyYy9kdGMnLi4uCmZhdGFsOiBDb3VsZCBub3QgcmVhZCBmcm9tIHJlbW90ZSBy
ZXBvc2l0b3J5LgoKUGxlYXNlIG1ha2Ugc3VyZSB5b3UgaGF2ZSB0aGUgY29ycmVjdCBhY2Nlc3Mg
cmlnaHRzCmFuZCB0aGUgcmVwb3NpdG9yeSBleGlzdHMuCmZhdGFsOiBjbG9uZSBvZiAnZ2l0Oi8v
Z2l0LnFlbXUtcHJvamVjdC5vcmcvZHRjLmdpdCcgaW50byBzdWJtb2R1bGUgcGF0aCAnL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWVndWJhYW9jL3NyYy9kdGMnIGZhaWxlZApGYWlsZWQgdG8g
Y2xvbmUgJ2R0YycuIFJldHJ5IHNjaGVkdWxlZApDbG9uaW5nIGludG8gJy92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC1lZ3ViYWFvYy9zcmMvZHRjJy4uLgpmYXRhbDogQ291bGQgbm90IHJlYWQg
ZnJvbSByZW1vdGUgcmVwb3NpdG9yeS4KClBsZWFzZSBtYWtlIHN1cmUgeW91IGhhdmUgdGhlIGNv
cnJlY3QgYWNjZXNzIHJpZ2h0cwphbmQgdGhlIHJlcG9zaXRvcnkgZXhpc3RzLgpmYXRhbDogY2xv
bmUgb2YgJ2dpdDovL2dpdC5xZW11LXByb2plY3Qub3JnL2R0Yy5naXQnIGludG8gc3VibW9kdWxl
IHBhdGggJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1lZ3ViYWFvYy9zcmMvZHRjJyBmYWls
ZWQKRmFpbGVkIHRvIGNsb25lICdkdGMnIGEgc2Vjb25kIHRpbWUsIGFib3J0aW5nCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
