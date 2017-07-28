Received: from eggs.gnu.org ([2001:4830:134:3::10]:33473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dazE6-0008T4-LJ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dazE2-0005mx-E4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 02:58:22 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-4-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d35b1732-e970-8f52-b09d-9b9e004be39f@redhat.com>
Date: Fri, 28 Jul 2017 08:58:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/47] MAINTAINERS: add missing STM32 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 28.07.2017 07:35, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 795f89f709..f10252c292 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -556,6 +556,7 @@ F: hw/char/stm32f2xx_usart.c
>  F: hw/timer/stm32f2xx_timer.c
>  F: hw/adc/*
>  F: hw/ssi/stm32f2xx_spi.c
> +F: include/hw/*/stm32*.h
> =20
>  Netduino 2
>  M: Alistair Francis <alistair@alistair23.me>
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
