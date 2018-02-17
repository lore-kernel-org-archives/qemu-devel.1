Received: from eggs.gnu.org ([2001:4830:134:3::10]:41946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1en2Zo-000474-IX
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 08:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1en2Zl-0005aL-EV
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 08:30:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1en2Zl-0005aE-8L
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 08:30:49 -0500
Date: Sat, 17 Feb 2018 13:30:45 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180217133045.GJ2450@redhat.com>
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518053328-34687-1-git-send-email-mjc@sifive.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>


I just want to mention that we've been running this patch set in
production for a few days, doing hundreds of Fedora RISC-V builds with
=E2=80=98-smp 4=E2=80=99 and it has been rock solid.

Therefore:

Tested-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
