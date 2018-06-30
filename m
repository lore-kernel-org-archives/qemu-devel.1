Received: from eggs.gnu.org ([2001:4830:134:3::10]:60394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <blanham@gmail.com>) id 1fZJKy-0004wY-2H
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 13:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <blanham@gmail.com>) id 1fZJKw-0002xF-Vr
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 13:07:04 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <blanham@gmail.com>) id 1fZJKw-0002w8-PK
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 13:07:02 -0400
Received: by mail-oi0-x241.google.com with SMTP id c2-v6so11214399oic.1
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 10:07:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180630153422.03f0146f@thl530.multi.box>
References: <20180630083357.23489-1-huth@tuxfamily.org>
	<bb109e75-6c00-45b2-bb17-7d09ff3a8112@ilande.co.uk>
	<20180630151444.2f0b30cb@thl530.multi.box>
	<CAFEAcA_wo8t2CTRj4oizRPUbG7fa0MgdACpAnLvR53Pp+piLjQ@mail.gmail.com>
	<20180630153422.03f0146f@thl530.multi.box>
From: Bryce Lanham <blanham@gmail.com>
Date: Sat, 30 Jun 2018 12:07:01 -0500
Message-ID: <CAKbio+kqcmD9vba-67wbyPX2Er7=cUP-vH1+FYrFK4ToZf9hCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/4] m68k: Add basic support for the
 NeXTcube machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Natalia Portillo <claunia@claunia.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

Oh hi!

Luckily gmail brought this to the top since I don=E2=80=99t pay attention t=
o the
list. I=E2=80=99m away from my computer at the moment, but I had more than =
this
working, including interrupts, Ethernet, and SCSI for sure. (
https://i.imgur.com/Py0FO.png) I=E2=80=99d love to dive back into this now =
that
68040 support is complete and merged.


On Sat, Jun 30, 2018 at 8:34 AM, Thomas Huth <huth@tuxfamily.org> wrote:

> Am Sat, 30 Jun 2018 14:17:32 +0100
> schrieb Peter Maydell <peter.maydell@linaro.org>:
>
> > On 30 June 2018 at 14:14, Thomas Huth <huth@tuxfamily.org> wrote:
> > > Weird... the mail was ca. 1200 lines ... that not small, but not so
> > > big that I'd expect that it would get blocked somewhere. Let's wait
> > > some more more hours, maybe the spam filter is just very slow
> > > today. If it is then still not available on the list, I'll try to
> > > send it out again.
> >
> > The mailing list does just occasionally randomly eat patches,
> > as far as I can tell. It's not purely a size thing.
>
> Ok, good to know. I've just sent out patch 3/4 again, let's see how it
> goes.
>
>  Thomas
>
