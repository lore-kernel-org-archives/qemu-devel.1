Received: from eggs.gnu.org ([209.51.188.92]:59914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0pRf-0003KM-1r
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h0pRe-0004kO-0q
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:23:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h0pRd-0004ha-O4
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:23:57 -0500
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
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b1eb9632-3322-bad3-8cd1-d716b8ae9322@redhat.com>
Date: Mon, 4 Mar 2019 16:23:42 +0100
MIME-Version: 1.0
In-Reply-To: <CABdVeAD2mfUR5-29NQ=jkWjLRt6wyQNJEk4hFOZYFsnKCgYZFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: David Kiarie <davidkiarie4@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Alexandro_S=c3=a1nchez_Bach?= <alexaltea123@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 04/03/2019 16.13, David Kiarie wrote:
>=20
>                             Hi David,
>=20
>                             On 2/23/19 11:54 AM, David Kiarie wrote:
>                             > Signed-off-by: David Kiarie
>                             <davidkiarie4@gmail.com
>                             <mailto:davidkiarie4@gmail.com>>
>                             > ---
>                             >=C2=A0 hw/i386/amd_iommu.c | 2 +-
>                             >=C2=A0 hw/i386/amd_iommu.h | 2 +-
>                             >=C2=A0 2 files changed, 2 insertions(+), 2
>                             deletions(-)
>                             >
>                             > diff --git a/hw/i386/amd_iommu.c
>                             b/hw/i386/amd_iommu.c
>                             > index 8ad707a..4f179da 100644
>                             > --- a/hw/i386/amd_iommu.c
>                             > +++ b/hw/i386/amd_iommu.c
>                             > @@ -2,7 +2,7 @@
>                             >=C2=A0 =C2=A0* QEMU emulation of AMD IOMMU=
 (AMD-Vi)
>                             >=C2=A0 =C2=A0*
>                             >=C2=A0 =C2=A0* Copyright (C) 2011 Eduard -=
 Gabriel
>                             Munteanu
>                             > - * Copyright (C) 2015 David Kiarie,
>                             <davidkiarie4@gmail.com
>                             <mailto:davidkiarie4@gmail.com>>
>                             > + * Copyright (C) 2016 David Kiarie Kahur=
ani
>=20
>                             Why do you change the year? Because your
>                             work was merged in 2016?
>=20
>=20
>                         no.
>                         =C2=A0
>=20
>=20
>                     though, if you have a legitimate issue with the
>                     change, you can always air it.
>=20
>=20
>                 you might think random emails are weird but Paolo, i
>                 don't expect to see any activity from you, on Qemu repo
>                 before this issue is sorted ;-)
>=20
>=20
>             i mostly don't care about this code but i *wrote* it. if i
>             am not allowed even make such minor(which i not a routine),
>             why shouldn't i ask you to take the files down?
>=20
>=20
>         or, rather, a small issue turns into a scene about how clean
>         Qemu is. why not take down all my dirty code?
>=20
>=20
>     look i'm=C2=A0resending this patch and next time we're having this
>     conversation, i'll be defacing qemu.
>=20
> either you have to update my code to what i think it should look like o=
r
> you have to take down - wtf
>=20
> then you try to cook rubbish over it.

Hey, calm down. Paolo said that he'd queue your patch, so it will
eventually get applied. But that just might take some time, the
maintainers only send PULL requests for their queued patches after a
couple of days. So relax, wait some days, and if your patch still did
not get applied in a week, then you can start complaining again.

 Thomas
