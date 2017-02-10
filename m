Received: from eggs.gnu.org ([2001:4830:134:3::10]:49333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cc4UF-0007cO-4M
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:15:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cc4UA-0000dC-C6
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:15:15 -0500
Resent-Message-Id: <E1cc4UA-0000dC-C6@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1cc4UA-0000cd-51
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:15:10 -0500
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20170210061200.15373-1-vapier@gentoo.org>
Message-ID: <148670730031.57.15552361064492617951@eba24e3a0d7f>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 9 Feb 2017 22:15:00 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] osdep.h: pull in sys/sysmacros.h for
 major/minor/makedev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vapier@gentoo.org
Cc: famz@redhat.com, qemu-devel@nongnu.org

SGksCgpZb3VyIHNlcmllcyBmYWlsZWQgYXV0b21hdGljIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5k
IHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZl
IGRvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHku
CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBvc2RlcC5oOiBwdWxsIGluIHN5cy9zeXNt
YWNyb3MuaCBmb3IgbWFqb3IvbWlub3IvbWFrZWRldgpNZXNzYWdlLWlkOiAyMDE3MDIxMDA2MTIw
MC4xNTM3My0xLXZhcGllckBnZW50b28ub3JnClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaApzZXQgLWUKZ2l0IHN1Ym1vZHVsZSB1cGRhdGUgLS1pbml0
IGR0YwojIExldCBkb2NrZXIgdGVzdHMgZHVtcCBlbnZpcm9ubWVudCBpbmZvCmV4cG9ydCBTSE9X
X0VOVj0xCmV4cG9ydCBKPTE2Cm1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNgptYWtlIGRv
Y2tlci10ZXN0LW1pbmd3QGZlZG9yYQptYWtlIGRvY2tlci10ZXN0LWJ1aWxkQG1pbi1nbGliCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVm
N2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNThiNGQ4ZSBv
c2RlcC5oOiBwdWxsIGluIHN5cy9zeXNtYWNyb3MuaCBmb3IgbWFqb3IvbWlub3IvbWFrZWRldgoK
PT09IE9VVFBVVCBCRUdJTiA9PT0KU3VibW9kdWxlICdkdGMnIChnaXQ6Ly9naXQucWVtdS1wcm9q
ZWN0Lm9yZy9kdGMuZ2l0KSByZWdpc3RlcmVkIGZvciBwYXRoICdkdGMnCmZhdGFsOiByZWFkIGVy
cm9yOiBDb25uZWN0aW9uIHJlc2V0IGJ5IHBlZXIKQ2xvbmluZyBpbnRvICdkdGMnLi4uCkNsb25l
IG9mICdnaXQ6Ly9naXQucWVtdS1wcm9qZWN0Lm9yZy9kdGMuZ2l0JyBpbnRvIHN1Ym1vZHVsZSBw
YXRoICdkdGMnIGZhaWxlZAo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQg
d2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
