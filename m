Received: from eggs.gnu.org ([2001:4830:134:3::10]:52048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5eEo-0004A8-V8
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5eEn-0002ik-Qe
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:49:51 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:43117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gabriel291075@gmail.com>)
	id 1e5eEn-0002iQ-Iv
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:49:49 -0400
Received: by mail-pf0-x241.google.com with SMTP id a8so12650107pfc.0
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 13:49:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2ed96187-82e5-c6b4-1bd1-14f68b583e24@redhat.com>
References: <1508513838-15530-1-git-send-email-gabriel291075@gmail.com>
	<2ed96187-82e5-c6b4-1bd1-14f68b583e24@redhat.com>
From: Gabriel Costa <gabriel291075@gmail.com>
Date: Fri, 20 Oct 2017 16:49:47 -0400
Message-ID: <CAG+oHk-egX1xjU9av-XZfAiiXoFXvReZznC-46FzF0HrX7qS2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 01/11] kinetis_k64_uart.h has been added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Thanks,

I found an example in [Qemu-devel] and in the next time I will include it.
also, I note now that I did not put [Qemu-devel] and arm: in the messages.
Should I resend everything corrected?


On Fri, Oct 20, 2017 at 4:18 PM, Eric Blake <eblake@redhat.com> wrote:

> On 10/20/2017 10:37 AM, Gabriel Augusto Costa wrote:
> > I made a new arm machine with some peripherals. The machine is
> mk64fn1m0, a
> > cortex-m4 microcontroller from NXP Kinetis family. The machine can run a
> > simple arm binary file using UART0 in polling mode.
> > I have prepared a series of patchs to include this machine:
>
> s/patchs/patches/
>
> > PATCH v3 n/11: It adds the machine and peripherals devices;
> > PATCH v4 n/2: It changes the Make files to compile this machine.
>
> Are the last three sentences really useful as part of the git commit
> message, or are they comments better directed to a cover letter?
> Remember, when sending a series, please include a 0/11 cover letter that
> all other messages are in-reply-to, rather than creating 11 separate
> top-level threads.
>
> More patch submission tips can be found at:
> https://wiki.qemu.org/Contribute/SubmitAPatch
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>
