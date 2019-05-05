Received: from eggs.gnu.org ([209.51.188.92]:54295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hNJib-0005fc-5m
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hNJiR-0000Ib-Gc
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:10:17 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731]:38509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hNJiR-0000HE-0I
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:10:15 -0400
Received: by mail-qk1-x731.google.com with SMTP id a64so661626qkg.5
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 09:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
	<20190504083638.13380-9-S.E.Harris@kent.ac.uk>
	<c05b4876-c55e-fd82-46d0-83be1b128cee@linaro.org>
In-Reply-To: <c05b4876-c55e-fd82-46d0-83be1b128cee@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sun, 5 May 2019 09:10:00 -0700
Message-ID: <CAK4993h0yCqpjBFzPy7GHt3kbSK43nLD6EXh4WFd_STHu15DTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target/avr: Register AVR support
 with the rest of QEMU, the build system, and the MAINTAINERS file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, QEMU Developers <qemu-devel@nongnu.org>, A.M.King@kent.ac.uk, E.J.C.Robbins@kent.ac.uk

Hi Richard.

I can maintain it

Sent from my cell phone, please ignore typos

On Sun, May 5, 2019, 8:57 AM Richard Henderson <richard.henderson@linaro.org>
wrote:

> On 5/4/19 1:36 AM, Sarah Harris wrote:
> > Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> ...
> >
> > +AVR
> > +M: Michael Rolnik <mrolnik@gmail.com>
> > +S: Odd Fixes
> > +F: target-avr/
> > +F: hw/avr/
> > +
>
> This is not how things work.  Michael wasn't up to maintaining the code 2
> years
> ago; that's why it was never committed.
>
> You would need to maintain this yourself, and for more than "Odd Fixes".
>
>
> r~
>
