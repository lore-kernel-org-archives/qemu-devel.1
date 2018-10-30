Received: from eggs.gnu.org ([2001:4830:134:3::10]:33283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHYE7-0000HQ-4y
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHYE6-0005mh-6j
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:54:50 -0400
MIME-Version: 1.0
References: <20181030174356.16915-1-palmer@sifive.com>
	<dc417db4-7add-0870-b6b7-6a3e4ae92305@redhat.com>
In-Reply-To: <dc417db4-7add-0870-b6b7-6a3e4ae92305@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Oct 2018 10:54:08 -0700
Message-ID: <CAKmqyKPKgGuArcN+46sHt5iPmEzGGanaOtjke+ku6dKaAu_U0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add qemu-riscv@nongnu.org as the RISC-V
 list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: philmd@redhat.com
Cc: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, Oct 30, 2018 at 10:53 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 30/10/18 18:43, Palmer Dabbelt wrote:
> > We now have a RISC-V specific QEMU development list.
> >
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

That's for testing, I was worried this would break the Linux boot :P

Alistair

>
> > ---
> >   MAINTAINERS | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d550fd8b809c..10983bd52d64 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -244,6 +244,7 @@ M: Palmer Dabbelt <palmer@sifive.com>
> >   M: Alistair Francis <Alistair.Francis@wdc.com>
> >   M: Sagar Karandikar <sagark@eecs.berkeley.edu>
> >   M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> > +L: qemu-riscv@nongnu.org
> >   S: Maintained
> >   F: target/riscv/
> >   F: hw/riscv/
> >
>
