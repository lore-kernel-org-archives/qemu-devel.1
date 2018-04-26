Received: from eggs.gnu.org ([2001:4830:134:3::10]:49424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBjyY-0005BA-8R
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBjyX-0004oO-HI
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:42:30 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:46651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fBjyX-0004ny-AX
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:42:29 -0400
Received: by mail-lf0-x243.google.com with SMTP id v85-v6so10139846lfa.13
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 09:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<1524699938-6764-9-git-send-email-mjc@sifive.com>
In-Reply-To: <1524699938-6764-9-git-send-email-mjc@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Apr 2018 16:42:02 +0000
Message-ID: <CAKmqyKPZcb2yG+-W3868uP1P1oAJRdwGj-ZTtuGPMBw70S-w1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 08/35] RISC-V: Make virt header comment
 title consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, patches@groups.riscv.org, palmer@sifive.com, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Wed, Apr 25, 2018 at 4:48 PM Michael Clark <mjc@sifive.com> wrote:

> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   include/hw/riscv/virt.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index 3a4f23e..91163d6 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -1,5 +1,5 @@
>   /*
> - * SiFive VirtIO Board
> + * QEMU RISC-V VirtIO machine interface
>    *
>    * Copyright (c) 2017 SiFive, Inc.
>    *
> --
> 2.7.0
