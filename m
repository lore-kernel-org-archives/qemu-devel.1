Received: from eggs.gnu.org ([209.51.188.92]:37752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1h0tHn-0001za-Gd
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1h0tHm-0007yU-20
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:30:03 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:41124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidkiarie4@gmail.com>)
	id 1h0tHj-0007wI-4q
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:29:59 -0500
Received: by mail-ot1-x336.google.com with SMTP id t7so5223448otk.8
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 11:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20190304151827.1813-1-davidkiarie4@gmail.com>
	<20190304151827.1813-2-davidkiarie4@gmail.com>
	<50ec8aca-252e-792f-9a9a-a5dc606eca9c@redhat.com>
	<CABdVeAAZXbC-5tPJd1ziAeKBVo+Bqt8We-hHDv_6bRd99YXmrg@mail.gmail.com>
In-Reply-To: <CABdVeAAZXbC-5tPJd1ziAeKBVo+Bqt8We-hHDv_6bRd99YXmrg@mail.gmail.com>
From: David Kiarie <davidkiarie4@gmail.com>
Date: Mon, 4 Mar 2019 22:29:10 +0300
Message-ID: <CABdVeADyxZ9Fpr0=ZqDJhH3hnBJ8F3RpoBuqk7ywKwT6WF4BGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] update copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Mar 4, 2019 at 10:20 PM David Kiarie <davidkiarie4@gmail.com> wrote=
:

>
>
> On Mon, Mar 4, 2019 at 8:48 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
> wrote:
>
>> On 3/4/19 4:18 PM, David Kiarie wrote:
>> > Signed-off-by: David Kiarie <davidkiarie4@gmail.com>
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>
> would i be wrong to say this patch received unwarranted scrutiny from you=
,
> Philippe?
>

i mean, given you have never been involved in any IOMMU work, i wouldn't
expect that you're in a position to asking questions about the copyright.


>
>
>> > ---
>> >  hw/i386/amd_iommu.c | 2 +-
>> >  hw/i386/amd_iommu.h | 2 +-
>> >  2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> > index 8ad707a..6eabdf9 100644
>> > --- a/hw/i386/amd_iommu.c
>> > +++ b/hw/i386/amd_iommu.c
>> > @@ -2,7 +2,7 @@
>> >   * QEMU emulation of AMD IOMMU (AMD-Vi)
>> >   *
>> >   * Copyright (C) 2011 Eduard - Gabriel Munteanu
>> > - * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com>
>> > + * Copyright (C) 2015, 2016 David Kiarie Kahurani
>> >   *
>> >   * This program is free software; you can redistribute it and/or modi=
fy
>> >   * it under the terms of the GNU General Public License as published =
by
>> > diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>> > index c52886f..0ff9095 100644
>> > --- a/hw/i386/amd_iommu.h
>> > +++ b/hw/i386/amd_iommu.h
>> > @@ -2,7 +2,7 @@
>> >   * QEMU emulation of an AMD IOMMU (AMD-Vi)
>> >   *
>> >   * Copyright (C) 2011 Eduard - Gabriel Munteanu
>> > - * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com>
>> > + * Copyright (C) 2015, 2016 David Kiarie Kahurani
>> >   *
>> >   * This program is free software; you can redistribute it and/or modi=
fy
>> >   * it under the terms of the GNU General Public License as published =
by
>> >
>>
>
