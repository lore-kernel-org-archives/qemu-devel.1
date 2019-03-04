Received: from eggs.gnu.org ([209.51.188.92]:34277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1h0paG-0002QG-6N
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1h0paF-0001TG-2w
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:32:52 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:39381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidkiarie4@gmail.com>)
	id 1h0paE-0001Q6-Qt
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:32:51 -0500
Received: by mail-oi1-x22c.google.com with SMTP id b4so4136658oif.6
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 07:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20190223105421.1290-1-davidkiarie4@gmail.com>
	<20190223105421.1290-2-davidkiarie4@gmail.com>
	<105ba509-af60-b47c-51cc-1e1c01fac56e@redhat.com>
	<CABdVeAAAMf=yDpuUvv3RxueGgrn+FOkQWy4J1DMq2fLXjv=bFQ@mail.gmail.com>
	<CABdVeAAmbW-hAq41KwbNtqbmndPd_nzB4Mw_7U8J+uBB5P=5Lw@mail.gmail.com>
	<CABdVeABUzvwA8jV8ZfTcDY8eWN5=M2Otku6eukaBsPeMqPNOhQ@mail.gmail.com>
	<CABdVeABnosV3-u9aepP=kSrb9P0X6-vUWZ2kDATUmNLmaJ_5+g@mail.gmail.com>
	<CABdVeACgD7NrRa+P9yzkjhNJAtf9JEaJKuzo+J3CMCxLUO3phQ@mail.gmail.com>
	<CABdVeACYb_TpARadx1FkQwODY7pqFp=Bm4RyZ3easb4Hm1JAyw@mail.gmail.com>
	<CABdVeAD2mfUR5-29NQ=jkWjLRt6wyQNJEk4hFOZYFsnKCgYZFg@mail.gmail.com>
	<b1eb9632-3322-bad3-8cd1-d716b8ae9322@redhat.com>
	<CABdVeADy4DerQj+9On5HP_M6Qa4jRJU0CvkUgiab+LV_XYa-6g@mail.gmail.com>
In-Reply-To: <CABdVeADy4DerQj+9On5HP_M6Qa4jRJU0CvkUgiab+LV_XYa-6g@mail.gmail.com>
From: David Kiarie <davidkiarie4@gmail.com>
Date: Mon, 4 Mar 2019 18:32:01 +0300
Message-ID: <CABdVeABf7Rg5sBzvWZ6ujwHMjwLo8jBRkoVGjDBR4fHRuLv1gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] hw/i386: update copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Alexandro_S=C3=A1nchez_Bach?= <alexaltea123@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Mar 4, 2019 at 6:27 PM David Kiarie <davidkiarie4@gmail.com> wrote:

>
>
> On Mon, Mar 4, 2019 at 6:23 PM Thomas Huth <thuth@redhat.com> wrote:
>
>> On 04/03/2019 16.13, David Kiarie wrote:
>> >
>> >                             Hi David,
>> >
>> >                             On 2/23/19 11:54 AM, David Kiarie wrote:
>> >                             > Signed-off-by: David Kiarie
>> >                             <davidkiarie4@gmail.com
>> >                             <mailto:davidkiarie4@gmail.com>>
>> >                             > ---
>> >                             >  hw/i386/amd_iommu.c | 2 +-
>> >                             >  hw/i386/amd_iommu.h | 2 +-
>> >                             >  2 files changed, 2 insertions(+), 2
>> >                             deletions(-)
>> >                             >
>> >                             > diff --git a/hw/i386/amd_iommu.c
>> >                             b/hw/i386/amd_iommu.c
>> >                             > index 8ad707a..4f179da 100644
>> >                             > --- a/hw/i386/amd_iommu.c
>> >                             > +++ b/hw/i386/amd_iommu.c
>> >                             > @@ -2,7 +2,7 @@
>> >                             >   * QEMU emulation of AMD IOMMU (AMD-Vi)
>> >                             >   *
>> >                             >   * Copyright (C) 2011 Eduard - Gabriel
>> >                             Munteanu
>> >                             > - * Copyright (C) 2015 David Kiarie,
>> >                             <davidkiarie4@gmail.com
>> >                             <mailto:davidkiarie4@gmail.com>>
>> >                             > + * Copyright (C) 2016 David Kiarie
>> Kahurani
>> >
>> >                             Why do you change the year? Because your
>> >                             work was merged in 2016?
>> >
>> >
>> >                         no.
>> >
>> >
>> >
>> >                     though, if you have a legitimate issue with the
>> >                     change, you can always air it.
>> >
>> >
>> >                 you might think random emails are weird but Paolo, i
>> >                 don't expect to see any activity from you, on Qemu repo
>> >                 before this issue is sorted ;-)
>> >
>> >
>> >             i mostly don't care about this code but i *wrote* it. if i
>> >             am not allowed even make such minor(which i not a routine),
>> >             why shouldn't i ask you to take the files down?
>> >
>> >
>> >         or, rather, a small issue turns into a scene about how clean
>> >         Qemu is. why not take down all my dirty code?
>> >
>> >
>> >     look i'm resending this patch and next time we're having this
>> >     conversation, i'll be defacing qemu.
>> >
>> > either you have to update my code to what i think it should look like or
>> > you have to take down - wtf
>> >
>> > then you try to cook rubbish over it.
>>
>> Hey, calm down. Paolo said that he'd queue your patch, so it will
>> eventually get applied. But that just might take some time, the
>> maintainers only send PULL requests for their queued patches after a
>> couple of days. So relax, wait some days, and if your patch still did
>> not get applied in a week, then you can start complaining again.
>>
>
> i'll not complain again, i'm make a patch to clean my code from your
> codebase.
>


Qemu have never been important to me like it's important to the maintainers.



>
>
>>
>>  Thomas
>>
>
