Received: from eggs.gnu.org ([2001:4830:134:3::10]:59332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJhAJ-0002KE-55
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJhAI-0001cW-Bp
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:51:47 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJhAI-0001TD-2h
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:51:46 -0500
Received: by mail-ot1-x343.google.com with SMTP id g10so8363009otl.12
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 07:51:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181102001303.32640-8-f4bug@amsat.org>
References: <20181102001303.32640-1-f4bug@amsat.org>
	<20181102001303.32640-8-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 15:51:20 +0000
Message-ID: <CAFEAcA_X6rAA181zpRFdViJKitwHAnN6EvvDS-SA-7znawsbow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.2 v2 7/7] MAINTAINERS: Volunteer to
 review Raspi patches
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c41ea5ed3f..a76d047659 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -684,6 +684,7 @@ F: hw/arm/microbit.c
>  F: include/hw/arm/nrf51_soc.h
>
>  Raspberry Pi
> +R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: hw/*/bcm283*
> --
> 2.17.2
>



Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
