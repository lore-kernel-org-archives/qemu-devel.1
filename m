Received: from eggs.gnu.org ([2001:4830:134:3::10]:43761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPeRw-0004pj-Md
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPeRv-0002Ho-BW
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:10:36 -0500
MIME-Version: 1.0
References: <20181121234651.24596-1-palmer@sifive.com>
	<20181121234651.24596-2-palmer@sifive.com>
In-Reply-To: <20181121234651.24596-2-palmer@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Nov 2018 18:10:06 -0800
Message-ID: <CAKmqyKM6_i_V2T-sc1eAJAMRCkacYHMiSCKcgg7xYHmXr7AfHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] MAINTAINERS: Mark RISC-V as
 Supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On Wed, Nov 21, 2018 at 3:55 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> There's three of us that are paid to work on this.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e89adc81d5d5..d5ec5e74f328 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -250,7 +250,7 @@ M: Alistair Francis <Alistair.Francis@wdc.com>
>  M: Sagar Karandikar <sagark@eecs.berkeley.edu>
>  M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>  L: qemu-riscv@nongnu.org
> -S: Maintained
> +S: Supported
>  F: target/riscv/
>  F: hw/riscv/
>  F: include/hw/riscv/
> --
> 2.18.1
>
>
