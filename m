Received: from eggs.gnu.org ([2001:4830:134:3::10]:39539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHAir-0007p6-KJ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHAiq-0000cX-Sx
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:49:01 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:43109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gHAiq-0000ap-JU
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 12:49:00 -0400
Received: by mail-lf1-x143.google.com with SMTP id u18so6568309lff.10
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 09:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181029161605.11486-1-palmer@sifive.com>
	<9cf83a16-250c-ff01-0783-74d5b2077999@redhat.com>
In-Reply-To: <9cf83a16-250c-ff01-0783-74d5b2077999@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Oct 2018 09:48:30 -0700
Message-ID: <CAKmqyKPXFOw3hv+wYbVPn2c4xPCiUXVyzDPJ3XpOuBx0zp9xGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add Alistair as a RISC-V Maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: philmd@redhat.com
Cc: Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Mon, Oct 29, 2018 at 9:44 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 29/10/18 17:16, Palmer Dabbelt wrote:
> > Alistair has been contributing to the RISC-V QEMU port for a while now
> > so I'd like him to be officially listed as a maintainer.  I've checked
> > with the other RISC-V mainatiners and there are no objectics, and I've
>
> "maintainers" "objections"
>
> > also checked with Alistair so he knows I'm volunteering him.
> >
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> FWIW:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

I can send a pull request with this patch (and the other RISC-V
patch). I'll fix the typos in the PR.

Alistair

>
> > ---
> >   MAINTAINERS | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d794bd7a66fe..d550fd8b809c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -241,6 +241,7 @@ F: disas/ppc.c
> >   RISC-V
> >   M: Michael Clark <mjc@sifive.com>
> >   M: Palmer Dabbelt <palmer@sifive.com>
> > +M: Alistair Francis <Alistair.Francis@wdc.com>
> >   M: Sagar Karandikar <sagark@eecs.berkeley.edu>
> >   M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> >   S: Maintained
> >
>
