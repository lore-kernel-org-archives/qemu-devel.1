Received: from eggs.gnu.org ([2001:4830:134:3::10]:45890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cEeXU-0008Ap-9o
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cEeXP-0003D6-Fb
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:53:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cEeXP-0003Cv-9b
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:53:43 -0500
Message-ID: <1481126020.11413.18.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 07 Dec 2016 16:53:40 +0100
In-Reply-To: <CAFEAcA-p1Ly=XQh4NqiHSt8YOvZn1OA_C638uPZd1ry+S8yb7A@mail.gmail.com>
References: <20161207125130.5184-1-fziglio@redhat.com>
	<CAFEAcA-p1Ly=XQh4NqiHSt8YOvZn1OA_C638uPZd1ry+S8yb7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] egl-helpers: Change file licensing to LGPL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Frediano Ziglio <fziglio@redhat.com>, Cole Robinson <crobinso@redhat.com>, Gonglei <arei.gonglei@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mi, 2016-12-07 at 14:45 +0000, Peter Maydell wrote:
> On 7 December 2016 at 12:51, Frediano Ziglio <fziglio@redhat.com> wrote:
> > Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> > ---
> >  ui/egl-helpers.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> > index 79cee05..cd24568 100644
> > --- a/ui/egl-helpers.c
> > +++ b/ui/egl-helpers.c
> > @@ -1,3 +1,19 @@
> > +/*
> > + * Copyright (C) 2015-2016 Gerd Hoffmann <kraxel@redhat.com>
>=20
> This looks a bit odd. Is the code copyright Gerd as an
> individual, or Red Hat as a company?

As individual, with email address added.

Although it probably doesn't make that much sense these days to put the
email into the source code as you can easily figure them from git
log ...

cheers,
  Gerd
