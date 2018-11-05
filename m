Received: from eggs.gnu.org ([2001:4830:134:3::10]:59273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJhAF-0002HB-Sq
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:51:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJhAC-0001R4-5r
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:51:40 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJhAB-0001C5-Dr
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:51:40 -0500
Received: by mail-ot1-x342.google.com with SMTP id 40so8164954oth.4
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 07:51:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102001303.32640-6-f4bug@amsat.org>
References: <20181102001303.32640-1-f4bug@amsat.org>
	<20181102001303.32640-6-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 15:51:08 +0000
Message-ID: <CAFEAcA_FJNMG=UjvsC1-C9Mg7Ri=fp5B11W0Qn5O11=tOsKM1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.2 v2 5/7] hw/arm/bcm2835: Add various
 unimplemented peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Guenter Roeck <linux@roeck-us.net>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 2 November 2018 at 00:13, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Base addresses and sizes taken from the "BCM2835 ARM Peripherals"
> datasheet from February 06 2012:
> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.p=
df
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/bcm2835_peripherals.c         | 26 ++++++++++++++++++++++++++
>  include/hw/arm/bcm2835_peripherals.h | 10 ++++++++++
>  include/hw/arm/raspi_platform.h      |  2 ++
>  3 files changed, 38 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
