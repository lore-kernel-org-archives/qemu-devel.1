Received: from eggs.gnu.org ([2001:4830:134:3::10]:56949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eCswZ-0001m2-MY
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eCswY-0005mA-UK
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:56:55 -0500
MIME-Version: 1.0
In-Reply-To: <1510228971-6005-1-git-send-email-sundeep.lkml@gmail.com>
References: <1510228971-6005-1-git-send-email-sundeep.lkml@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Nov 2017 11:56:22 -0800
Message-ID: <CAKmqyKOzUD-u=+zW3CNJO6S_=y0u-0EiBu=YQpgmXzhW7L=vXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel PATCH] MAINTAINERS: Add entries for
 Smartfusion2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Thu, Nov 9, 2017 at 4:02 AM, Subbaraya Sundeep
<sundeep.lkml@gmail.com> wrote:
> add voluntarily myself as maintainer for Smartfusion2

This should be:
Voluntarily add myself as maintainer for Smartfusion2.

>
> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>

With the commit message fixed:

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  MAINTAINERS | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0cd4d02..dae08bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -564,6 +564,23 @@ M: Alistair Francis <alistair@alistair23.me>
>  S: Maintained
>  F: hw/arm/netduino2.c
>
> +MSF2 SoC
> +M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> +S: Maintained
> +F: hw/arm/msf2-soc.c
> +F: hw/misc/msf2-sysreg.c
> +F: hw/timer/mss-timer.c
> +F: hw/ssi/mss-spi.c
> +F: include/hw/arm/msf2-soc.h
> +F: include/hw/misc/msf2-sysreg.h
> +F: include/hw/timer/mss-timer.h
> +F: include/hw/ssi/mss-spi.h
> +
> +MSF2 SOM board
> +M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> +S: Maintained
> +F: hw/arm/msf2-som.c
> +
>  CRIS Machines
>  -------------
>  Axis Dev88
> --
> 2.5.0
>
