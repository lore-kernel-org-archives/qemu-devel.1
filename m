Received: from eggs.gnu.org ([209.51.188.92]:51689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLV2T-0006WW-Se
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLV2T-0007fU-2Z
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:51:25 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLV2R-0007do-Tm
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:51:24 -0400
Received: by mail-ot1-x343.google.com with SMTP id g8so11355975otl.8
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 08:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB027793B449E7DAAB995E0F33DD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<1c2303a0-62bf-53ce-e91c-b45a95a91376@redhat.com>
	<CAKmqyKMWHot3UaRkN4gnwtcj7kje-Yx3ZJa7-9NGbgfg6vMJdQ@mail.gmail.com>
In-Reply-To: <CAKmqyKMWHot3UaRkN4gnwtcj7kje-Yx3ZJa7-9NGbgfg6vMJdQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 16:51:09 +0100
Message-ID: <CAFEAcA-UaW=0QpCcLo4_HkKHskhvAJhnCBm949Dbr8qBNM8aJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/5] hw/arm: Add the STM32F4xx SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, 29 Apr 2019 at 18:30, Alistair Francis <alistair23@gmail.com> wrote=
:
>
> On Mon, Apr 29, 2019 at 5:43 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > On 4/29/19 7:33 AM, Alistair Francis wrote:
> > > --- /dev/null
> > > +++ b/hw/arm/stm32f405_soc.c
> > > @@ -0,0 +1,292 @@
> > > +/*
> > > + * STM32F405 SoC
> > > + *
> > > + * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
> >
> > 2019?
>
> I never know how this works. It was originally written in 2014, do I
> update the year based on the upstream submission?

You could say "2014, 2019" if you like; or just use the date of
original authorship.

thanks
-- PMM
