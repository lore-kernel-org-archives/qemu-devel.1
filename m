Received: from eggs.gnu.org ([2001:4830:134:3::10]:57131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJh5u-00040O-TG
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJgzD-0003di-TM
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:40:24 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJgzC-0003Vr-Ru
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:40:19 -0500
Received: by mail-ot1-x343.google.com with SMTP id q5so8302247otl.13
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 07:40:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102001303.32640-5-f4bug@amsat.org>
References: <20181102001303.32640-1-f4bug@amsat.org>
	<20181102001303.32640-5-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 15:39:55 +0000
Message-ID: <CAFEAcA_QcFwahwXYi-GCGdbdsOO+e7gExQbYNYWzL2V6274bdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.2 v2 4/7] hw/arm/bcm2835: Rename some
 definitions
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
> The UART1 is part of the AUX peripheral,
> the PCM_CLOCK (yet unimplemented) is part of the CPRMAN.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/bcm2835_peripherals.c    | 2 +-
>  include/hw/arm/raspi_platform.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
