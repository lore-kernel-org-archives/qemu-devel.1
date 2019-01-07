Received: from eggs.gnu.org ([209.51.188.92]:52215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ggRei-0007JS-K6
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ggReh-0005Tg-SX
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:57:12 -0500
References: <20190104175847.6290-1-philmd@redhat.com>
	<20190104175847.6290-3-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <58b91746-5462-c4b4-226b-c0063d69c988@redhat.com>
Date: Mon, 7 Jan 2019 10:56:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190104175847.6290-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/16] hw: Remove unused 'hw/devices.h'
 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Michael Walle <michael@walle.cc>, qemu-trivial@nongnu.org, Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>

On 2019-01-04 18:58, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/alpha/typhoon.c                       | 1 -
>  hw/arm/allwinner-a10.c                   | 1 -
>  hw/arm/collie.c                          | 1 -
>  hw/arm/cubieboard.c                      | 1 -
>  hw/arm/highbank.c                        | 1 -
>  hw/arm/mps2-tz.c                         | 1 -
>  hw/arm/musicpal.c                        | 1 -
>  hw/arm/nrf51_soc.c                       | 1 -
>  hw/arm/spitz.c                           | 1 -
>  hw/arm/virt.c                            | 1 -
>  hw/arm/z2.c                              | 1 -
>  hw/display/sm501.c                       | 1 -
>  hw/hppa/dino.c                           | 1 -
>  hw/intc/allwinner-a10-pic.c              | 1 -
>  hw/lm32/lm32_boards.c                    | 1 -
>  hw/lm32/milkymist.c                      | 1 -
>  hw/microblaze/petalogix_ml605_mmu.c      | 1 -
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 -
>  hw/net/dp8393x.c                         | 1 -
>  hw/ppc/virtex_ml507.c                    | 1 -
>  hw/sh4/r2d.c                             | 1 -
>  hw/tricore/tricore_testboard.c           | 1 -
>  hw/usb/tusb6010.c                        | 1 -
>  23 files changed, 23 deletions(-)

Works for me.

Tested-by: Thomas Huth <thuth@redhat.com>
