Received: from eggs.gnu.org ([2001:4830:134:3::10]:43037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZ1Qt-0007oY-Ao
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZ1Qs-0008CT-DM
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:27:43 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eZ1Qs-0008Bp-6T
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 16:27:42 -0500
Received: by mail-wr0-x244.google.com with SMTP id s13so13131817wra.10
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 13:27:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1514940265-18093-2-git-send-email-mjc@sifive.com>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-2-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 9 Jan 2018 13:27:10 -0800
Message-ID: <CAKmqyKNDjTh-2qJGodoL_3AxgPHMvk7Ycmrcrgm4XYW_sOkxdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 01/21] RISC-V Maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Tue, Jan 2, 2018 at 4:44 PM, Michael Clark <mjc@sifive.com> wrote:
> Add Michael Clark, Sagar Karandikar and Bastian Koppelmann as
> RISC-V Maintainers.
>
> Signed-off-by: Michael Clark <mjc@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73a5555..09a1314 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -209,6 +209,16 @@ F: hw/ppc/
>  F: include/hw/ppc/
>  F: disas/ppc.c
>
> +RISC-V
> +M: Michael Clark <mjc@sifive.com>
> +M: Sagar Karandikar <sagark@eecs.berkeley.edu>
> +M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> +S: Maintained
> +F: target/riscv/
> +F: hw/riscv/
> +F: include/hw/riscv/
> +F: disas/riscv.c
> +
>  S390
>  M: Richard Henderson <rth@twiddle.net>
>  M: Alexander Graf <agraf@suse.de>
> --
> 2.7.0
>
>
