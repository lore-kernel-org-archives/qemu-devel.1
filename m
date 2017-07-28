Received: from eggs.gnu.org ([2001:4830:134:3::10]:40619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dbF89-0001jH-2l
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dbF88-0004sO-C0
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:57:17 -0400
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-40-f4bug@amsat.org>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-40-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jul 2017 16:56:42 -0700
Message-ID: <CAKmqyKOonEpSCs2k-qJrOP76TV3Nnk08A1s7nBRJV-Ok+q4kow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 39/47] MAINTAINERS: add missing SSI entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Jul 27, 2017 at 10:36 PM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> RFC because I'm not sure m25p80 fits.
>
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 54e35fdab9..83597fca4e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1010,7 +1010,9 @@ M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>  S: Maintained
>  F: hw/ssi/*
>  F: hw/block/m25p80.c
> +F: include/hw/ssi/ssi.h
>  X: hw/ssi/xilinx_*
> +F: tests/m25p80-test.c

I'm not sure if Peter is still maintaining this. Maybe it's worth
adding another Xilinx email in here as well.

Thanks,
Alistair

>
>  Xilinx SPI
>  M: Alistair Francis <alistair.francis@xilinx.com>
> --
> 2.13.3
>
>
