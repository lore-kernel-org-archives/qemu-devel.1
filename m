Received: from eggs.gnu.org ([2001:4830:134:3::10]:46979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1eyDHh-0004ME-TX
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1eyDHc-0003Wp-N3
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:10:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:54849)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1eyDHc-0003W4-GI
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:10:16 -0400
From: Andreas Schwab <schwab@suse.de>
References: <mvm1sggjazj.fsf@suse.de>
	<CAHNT7NuOLVGyodcJ98ruM5t+m1s=in07dXfNp_77=vTOb=1yhQ@mail.gmail.com>
Date: Tue, 20 Mar 2018 10:10:14 +0100
In-Reply-To: <CAHNT7NuOLVGyodcJ98ruM5t+m1s=in07dXfNp_77=vTOb=1yhQ@mail.gmail.com>
	(Michael Clark's message of "Mon, 19 Mar 2018 15:10:46 -0700")
Message-ID: <mvmfu4vi03t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu:handle_cpu_signal received signal outside
 vCPU context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On M=C3=A4r 19 2018, Michael Clark <mjc@sifive.com> wrote:

> I wonder what is the best way for me to reproduce on my side... a tarba=
ll
> with binaries that I can use to trigger the fault?

The easiest way, if you have an OBS account, is to check out the package
at <https://build.opensuse.org/package/show/openSUSE:Factory:RISCV/gedit>
with osc and use osc build.

Andreas.

--=20
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
"And now for something completely different."
