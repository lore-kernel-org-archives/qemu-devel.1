Received: from eggs.gnu.org ([2001:4830:134:3::10]:44925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eyiSO-0007nz-84
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eyiSM-0007qM-Ub
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:27:28 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:42390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eyiSM-0007px-NA
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 14:27:26 -0400
Received: by mail-ot0-x243.google.com with SMTP id v23-v6so6665337oth.9
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:27:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7534728b-1511-3ba1-57b1-03423b83ad87@redhat.com>
References: <1521584722-39133-1-git-send-email-mjc@sifive.com>
	<7534728b-1511-3ba1-57b1-03423b83ad87@redhat.com>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 21 Mar 2018 11:27:25 -0700
Message-ID: <CAHNT7NvJ42AApKcprrZ+s7bMxxbL1S1ZdX9aTjQTwd=fbFQU6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] RISC-V Post-merge spec conformance
 and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Wed, Mar 21, 2018 at 12:05 AM, Thomas Huth <thuth@redhat.com> wrote:

> On 20.03.2018 23:25, Michael Clark wrote:
> > The following changes since commit f1a63fcfcd92c88be8942b5ae71aef
> 9749a4f135:
> >
> >   Update version for v2.12.0-rc0 release (2018-03-20 19:04:22 +0000)
> >
> > are available in the git repository at:
> >
> >   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-2.12-fixes
> >
> > for you to fetch changes up to e1a247183ac0816284dfda61423f7030b6686679:
> >
> >   RISC-V: Remove erroneous comment from translate.c (2018-03-20 14:34:13
> -0700)
> >
> > ----------------------------------------------------------------
> > This is a series of spec conformance bug fixes and code cleanups
> > that we would like to get in before the QEMU 2.12 release.
>
>  Hi Michael,
>
> for future PULL request, could you please send out all patches again
> that should be pulled, and not send the cover letter alone? I.e. do a
> "git format-patch --subject-prefix PULL ..." and then replace the
> contents of the cover letter with the output of "git request-pull".
>

No problem. Thanks for the advice. I was grappling with this part of the
process. This is now very clear and makes complete sense.


> ... this is how all other maintainers are sending PULL requests (at
> least as far as I know) and this way everybody gets a very final chance
> to have a look at the patches in their final state (it does not happen
> very often that someone replies to such patches, but in some rare cases
> we already found problems this way).
>
>  Thank you very much for your efforts,
>   Thomas
>
>
