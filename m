Received: from eggs.gnu.org ([2001:4830:134:3::10]:41422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dKsUa-0000TC-9t
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1dKsUZ-0005go-EW
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:32:48 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:32886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1dKsUZ-0005gE-7k
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 16:32:47 -0400
Received: by mail-wr0-x243.google.com with SMTP id v104so33531616wrb.0
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 13:32:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <bcd25371-e16f-4fe5-6298-f273720cbaad@tuxfamily.org>
References: <20170608184944.19406-1-mrolnik@gmail.com>
	<20170608184944.19406-2-mrolnik@gmail.com>
	<bcd25371-e16f-4fe5-6298-f273720cbaad@tuxfamily.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 13 Jun 2017 23:32:05 +0300
Message-ID: <CAK4993gCQsJKy-nK4NNS=+v3-zLhM8S5iyHnLUmjqHvFMEmzoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC v19 01/13] target-avr: AVR cores
 support is added.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Anichang <anichang@protonmail.ch>

the last version of my patches were done by Richard. Now I just reapplied
them to the master.
Should I have to remove "signed-off-by Richard" ?

On Tue, Jun 13, 2017 at 11:09 PM, Thomas Huth <huth@tuxfamily.org> wrote:

> On 08.06.2017 20:49, Michael Rolnik wrote:
> >     1. basic CPU structure
> >     2. registers
> >     3. no instructions
> >     4. saving sreg, rampD, rampX, rampY, rampD, eind in HW representation
> >
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Message-Id: <1471522070-77598-2-git-send-email-mrolnik@gmail.com>
> > Signed-off-by: Richard Henderson <rth@twiddle.net>
>
> Why is the final "Signed-off-by" by Richard, if the patch has apparently
> been sent by you, Michael? Something is wrong here with the order...
>
>  Thomas
>



-- 
Best Regards,
Michael Rolnik
