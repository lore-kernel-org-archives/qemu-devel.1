Received: from eggs.gnu.org ([2001:4830:134:3::10]:33350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gHYEI-0000WF-AH
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gHYEE-0005qm-8E
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:55:02 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gHYEE-0005qJ-3Z
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:54:58 -0400
Received: by mail-yb1-f194.google.com with SMTP id d18-v6so5423276yba.4
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 10:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_oMG2qo_W_OFfdkPomu7-hc4vkFSZnC0CLQ_PD6zmW+Q@mail.gmail.com>
	<mhng-b2717513-e93b-43da-b724-f2adca348413@palmer-si-x1c4>
	<CAFEAcA_AYKP0ApmkdSXFn_pQRq3vVBbijbg7WDfTawPkvApQxw@mail.gmail.com>
In-Reply-To: <CAFEAcA_AYKP0ApmkdSXFn_pQRq3vVBbijbg7WDfTawPkvApQxw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Tue, 30 Oct 2018 18:54:45 +0100
Message-ID: <CAAdtpL5c21ZTKEVTh3iBP=gJVbuHrkq8k5YBY0KN8dRWBSVjRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Add Alistair as a RISC-V Maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair23@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Tue, Oct 30, 2018 at 4:04 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On 29 October 2018 at 18:41, Palmer Dabbelt <palmer@sifive.com> wrote:
> > On Mon, 29 Oct 2018 10:59:47 PDT (-0700), Peter Maydell wrote:
> >>
> >> On 29 October 2018 at 17:14, Palmer Dabbelt <palmer@sifive.com> wrote:
> >>>
> >>> I don't think we have anything ready to go right now: your PCIe patches
> >>> still have some outstanding feedback (on interrupt stuff), and Bastian's
> >>> decodetree stuff has some patches from Richard Henderson that should be
> >>> merged in.  I was hoping to get through reviewing Michael's patches to
> >>> fix
> >>> the FS dirty bit, but haven't had time yet -- they're tested, but I
> >>> haven't
> >>> actually read through them.
> >>>
> >>> Maybe we should get a RISC-V QEMU mailing list so we can keep everyone in
> >>> sync without spamming the whole world?
> >>
> >>
> >> We can sort out a qemu-riscv mailing list like the ones we have
> >> for ppc and arm if you like:
> >> https://wiki.qemu.org/Contribute/MailingLists
> >
> >
> > I think that'd be good.  It makes things a bit easier on my end as I can
> > ensure I don't miss any patches that end up on our list.
>
> OK, I have set one up. The subscription page is at:
> https://lists.nongnu.org/mailman/listinfo/qemu-riscv

Thanks!

> I think I have got the list config correct but let me know if you
> notice anything weird.

http://lists.nongnu.org/archive/html/qemu-riscv/ returns 404 Not
found: The requested URL /archive/html/qemu-riscv/ was not found on
this server.

This might be a cron job and I need to wait.

>
> I suggest submitting a patch to MAINTAINERS that adds an
> L: qemu-riscv@nongnu.org
> line to the RISC-V section of that file.
>
> thanks
> -- PMM
>
