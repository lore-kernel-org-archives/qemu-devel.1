Received: from eggs.gnu.org ([2001:4830:134:3::10]:39389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dnCBp-0004vg-Kq
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 19:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dnCBo-000855-T6
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 19:14:29 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170830215523.25278-11-f4bug@amsat.org>
References: <20170830215523.25278-1-f4bug@amsat.org>
	<20170830215523.25278-11-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 30 Aug 2017 16:13:55 -0700
Message-ID: <CAKmqyKOmhv38V5_knG2uNpzQtwdm23oFkVUccF7dF8DTBdzphA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/17] MAINTAINERS: add missing SSI
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Aug 30, 2017 at 2:55 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Alistair Francis volunteered :)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bbe1191883..0a3a50aa25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -986,10 +986,13 @@ F: hw/scsi/lsi53c895a.c
>
>  SSI
>  M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> +M: Alistair Francis <alistair.francis@xilinx.com>
>  S: Maintained
>  F: hw/ssi/*
>  F: hw/block/m25p80.c
> +F: include/hw/ssi/ssi.h
>  X: hw/ssi/xilinx_*
> +F: tests/m25p80-test.c
>
>  Xilinx SPI
>  M: Alistair Francis <alistair.francis@xilinx.com>
> --
> 2.14.1
>
>
