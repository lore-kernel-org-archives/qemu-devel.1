Received: from eggs.gnu.org ([2001:4830:134:3::10]:51189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHbeC-0006MG-VM
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHbe8-0003Yo-B8
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:33:58 -0400
MIME-Version: 1.0
References: <20181030212249.7117-1-palmer@sifive.com>
	<20181030212249.7117-3-palmer@sifive.com>
In-Reply-To: <20181030212249.7117-3-palmer@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Oct 2018 14:33:23 -0700
Message-ID: <CAKmqyKP8sic_SEiqugH2=119GcyZQthv=QVds0c00J0W5uXc2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 2/3] Add Alistair as a RISC-V Maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: qemu-riscv@nongnu.org, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, Oct 30, 2018 at 2:23 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> Alistair has been contributing to the RISC-V QEMU port for a while now
> so I'd like him to be officially listed as a maintainer.  I've checked
> with the other RISC-V maintainers and there are no objections, and I've
> also checked with Alistair so he knows I'm volunteering him.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Hey Palmer,

It looks like you dropped a Reviewed by here. It's not super important
in this case but for future patches it could be an issue.

If you use QEMU's patches it should apply the tags for you:
https://github.com/stefanha/patches

Alistair

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d794bd7a66fe..d550fd8b809c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -241,6 +241,7 @@ F: disas/ppc.c
>  RISC-V
>  M: Michael Clark <mjc@sifive.com>
>  M: Palmer Dabbelt <palmer@sifive.com>
> +M: Alistair Francis <Alistair.Francis@wdc.com>
>  M: Sagar Karandikar <sagark@eecs.berkeley.edu>
>  M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>  S: Maintained
> --
> 2.18.1
>
>
