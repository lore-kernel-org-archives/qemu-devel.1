Received: from eggs.gnu.org ([209.51.188.92]:55991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1h0pC2-0001Dn-2v
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1h0pC1-00069k-2r
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:07:50 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:40359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidkiarie4@gmail.com>)
	id 1h0pC0-00068C-Qc
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:07:49 -0500
Received: by mail-ot1-x32d.google.com with SMTP id v20so4457208otk.7
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 07:07:48 -0800 (PST)
MIME-Version: 1.0
References: <20190223105421.1290-1-davidkiarie4@gmail.com>
	<20190223105421.1290-2-davidkiarie4@gmail.com>
	<105ba509-af60-b47c-51cc-1e1c01fac56e@redhat.com>
	<CABdVeAAAMf=yDpuUvv3RxueGgrn+FOkQWy4J1DMq2fLXjv=bFQ@mail.gmail.com>
	<CABdVeAAmbW-hAq41KwbNtqbmndPd_nzB4Mw_7U8J+uBB5P=5Lw@mail.gmail.com>
	<CABdVeABUzvwA8jV8ZfTcDY8eWN5=M2Otku6eukaBsPeMqPNOhQ@mail.gmail.com>
	<CABdVeABnosV3-u9aepP=kSrb9P0X6-vUWZ2kDATUmNLmaJ_5+g@mail.gmail.com>
	<CABdVeACgD7NrRa+P9yzkjhNJAtf9JEaJKuzo+J3CMCxLUO3phQ@mail.gmail.com>
In-Reply-To: <CABdVeACgD7NrRa+P9yzkjhNJAtf9JEaJKuzo+J3CMCxLUO3phQ@mail.gmail.com>
From: David Kiarie <davidkiarie4@gmail.com>
Date: Mon, 4 Mar 2019 18:06:59 +0300
Message-ID: <CABdVeACYb_TpARadx1FkQwODY7pqFp=Bm4RyZ3easb4Hm1JAyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] hw/i386: update copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Alexandro_S=C3=A1nchez_Bach?= <alexaltea123@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>

On Mon, Mar 4, 2019 at 5:40 PM David Kiarie <davidkiarie4@gmail.com> wrote:

>
>
> On Mon, Mar 4, 2019 at 5:36 PM David Kiarie <davidkiarie4@gmail.com>
> wrote:
>
>>
>>
>> On Mon, Mar 4, 2019 at 5:10 PM David Kiarie <davidkiarie4@gmail.com>
>> wrote:
>>
>>>
>>>
>>> On Mon, Mar 4, 2019 at 4:42 PM David Kiarie <davidkiarie4@gmail.com>
>>> wrote:
>>>
>>>>
>>>>
>>>> On Mon, Mar 4, 2019 at 3:57 PM David Kiarie <davidkiarie4@gmail.com>
>>>> wrote:
>>>>
>>>>>
>>>>>
>>>>> On Mon, Mar 4, 2019 at 2:57 PM Philippe Mathieu-Daud=C3=A9 <
>>>>> philmd@redhat.com> wrote:
>>>>>
>>>>>> Hi David,
>>>>>>
>>>>>> On 2/23/19 11:54 AM, David Kiarie wrote:
>>>>>> > Signed-off-by: David Kiarie <davidkiarie4@gmail.com>
>>>>>> > ---
>>>>>> >  hw/i386/amd_iommu.c | 2 +-
>>>>>> >  hw/i386/amd_iommu.h | 2 +-
>>>>>> >  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>> >
>>>>>> > diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>>>>> > index 8ad707a..4f179da 100644
>>>>>> > --- a/hw/i386/amd_iommu.c
>>>>>> > +++ b/hw/i386/amd_iommu.c
>>>>>> > @@ -2,7 +2,7 @@
>>>>>> >   * QEMU emulation of AMD IOMMU (AMD-Vi)
>>>>>> >   *
>>>>>> >   * Copyright (C) 2011 Eduard - Gabriel Munteanu
>>>>>> > - * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com>
>>>>>> > + * Copyright (C) 2016 David Kiarie Kahurani
>>>>>>
>>>>>> Why do you change the year? Because your work was merged in 2016?
>>>>>>
>>>>>
>>>>> no.
>>>>>
>>>>>
>>>>
>>>> though, if you have a legitimate issue with the change, you can always
>>>> air it.
>>>>
>>>
>>> you might think random emails are weird but Paolo, i don't expect to se=
e
>>> any activity from you, on Qemu repo before this issue is sorted ;-)
>>>
>>
>> i mostly don't care about this code but i *wrote* it. if i am not allowe=
d
>> even make such minor(which i not a routine), why shouldn't i ask you to
>> take the files down?
>>
>
> or, rather, a small issue turns into a scene about how clean Qemu is. why
> not take down all my dirty code?
>

look i'm resending this patch and next time we're having this conversation,
i'll be defacing qemu.


>
>
>>
>>
>>>
>>>
>>>>
>>>>
>>>>>
>>>>>> >   *
>>>>>> >   * This program is free software; you can redistribute it and/or
>>>>>> modify
>>>>>> >   * it under the terms of the GNU General Public License as
>>>>>> published by
>>>>>> > diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
>>>>>> > index c52886f..cb258a7 100644
>>>>>> > --- a/hw/i386/amd_iommu.h
>>>>>> > +++ b/hw/i386/amd_iommu.h
>>>>>> > @@ -2,7 +2,7 @@
>>>>>> >   * QEMU emulation of an AMD IOMMU (AMD-Vi)
>>>>>> >   *
>>>>>> >   * Copyright (C) 2011 Eduard - Gabriel Munteanu
>>>>>> > - * Copyright (C) 2015 David Kiarie, <davidkiarie4@gmail.com>
>>>>>> > + * Copyright (C) 2016 David Kiarie Kahurani
>>>>>> >   *
>>>>>> >   * This program is free software; you can redistribute it and/or
>>>>>> modify
>>>>>> >   * it under the terms of the GNU General Public License as
>>>>>> published by
>>>>>> >
>>>>>>
>>>>>
