Received: from eggs.gnu.org ([2001:4830:134:3::10]:54280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tblodt@icloud.com>) id 1dUgvm-0004Cg-9k
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tblodt@icloud.com>) id 1dUgvi-0006F9-AP
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:13:26 -0400
Received: from st13p21im-asmtp004.me.com ([17.164.152.26]:62139)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tblodt@icloud.com>) id 1dUgvi-0006Ea-5f
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:13:22 -0400
Received: from process-dkim-sign-daemon.st13p21im-asmtp004.me.com by
	st13p21im-asmtp004.me.com
	(Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26
	2016)) id <0OSW00O00AVETM00@st13p21im-asmtp004.me.com> for
	qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:13:20 +0000 (GMT)
Content-type: text/plain; charset=utf-8
MIME-version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Theodore Dubois <tblodt@icloud.com>
In-reply-to: <d2f285a7-4bba-5ece-f327-fc4c5e61296e@redhat.com>
Date: Mon, 10 Jul 2017 15:13:16 -0700
Content-transfer-encoding: quoted-printable
Message-id: <50811290-839A-4F06-9D90-4D6E45BB3DB4@icloud.com>
References: <D5741445-7EFD-4AF1-8DB2-E4AFA93CBB1A@icloud.com>
	<d2f285a7-4bba-5ece-f327-fc4c5e61296e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] test-i386: Make x86 test program compile
 on clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

I don=E2=80=99t believe so, I haven=E2=80=99t been able to find it in =
the bug database.

~Theodore

> On Jul 10, 2017, at 2:48 PM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> On 10/07/2017 22:57, Theodore Dubois wrote:
>>  - Clang doesn't support size suffixes on the loop instructions.
>=20
> Has this bug been reported?
>=20
> Paolo
>=20
