Received: from eggs.gnu.org ([2001:4830:134:3::10]:60028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHYAB-0005s8-L0
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gHYAA-0002jC-Oq
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:50:47 -0400
MIME-Version: 1.0
References: <20181030174356.16915-1-palmer@sifive.com>
In-Reply-To: <20181030174356.16915-1-palmer@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Oct 2018 10:50:15 -0700
Message-ID: <CAKmqyKOV5HaD-gegE1T0_DhBFffi27wJNa_pAg-xDHOS=L5gnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Palmer Dabbelt <palmer@sifive.com>
Cc: qemu-riscv@nongnu.org, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, Oct 30, 2018 at 10:45 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> We now have a RISC-V specific QEMU development list.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d550fd8b809c..10983bd52d64 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -244,6 +244,7 @@ M: Palmer Dabbelt <palmer@sifive.com>
>  M: Alistair Francis <Alistair.Francis@wdc.com>
>  M: Sagar Karandikar <sagark@eecs.berkeley.edu>
>  M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> +L: qemu-riscv@nongnu.org
>  S: Maintained
>  F: target/riscv/
>  F: hw/riscv/
> --
> 2.18.1
>
>
