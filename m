Received: from eggs.gnu.org ([2001:4830:134:3::10]:41631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dYPHK-0000tP-Jq
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 00:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dYPHF-0000YS-SQ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 00:11:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dYPHF-0000XW-MW
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 00:10:57 -0400
Date: Fri, 21 Jul 2017 12:10:53 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170721041053.GQ11032@lemon>
References: <CAB3eZfs8E0xsBAFH_4U=M4LsVpRs73aPdFk5qy_ZUKqMom9P8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB3eZfs8E0xsBAFH_4U=M4LsVpRs73aPdFk5qy_ZUKqMom9P8g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] unrecognized option --object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>
Cc: qemu-devel@nongnu.org

On Thu, 07/20 19:06, =E9=99=B3=E5=9F=B9=E6=B3=93 wrote:
> I build qemu from the https://github.com/qemu/qemu, and it didn't show =
any
> errors.
>=20
> I tried qemu-nbd --object secret,id=3Dsec0...
> but it shows unrecognized option '--object '
>=20
> how to solve it?

-object it is. Thanks.

Fam
