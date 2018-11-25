Received: from eggs.gnu.org ([2001:4830:134:3::10]:43100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gR3EX-0000Zy-0Q
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 17:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gR3EW-0007MH-Bi
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 17:50:32 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:47021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gR3EW-0007Kz-6N
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 17:50:32 -0500
Received: by mail-ot1-x343.google.com with SMTP id w25so14896652otm.13
	for <qemu-devel@nongnu.org>; Sun, 25 Nov 2018 14:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-7-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-7-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Nov 2018 22:50:19 +0000
Message-ID: <CAFEAcA_ujDFu_X0cm5gVppESYeZ4KfNwjJkVKrsCNRgBeeQ1OA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 06/25] MAINTAINERS: Add a missing
 entry for the Xilinx S3A-DSP 1800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Sun, 25 Nov 2018 at 20:51, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e396cbe71..aa17e9bbd3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -822,6 +822,7 @@ petalogix_s3adsp1800
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
>  F: hw/microblaze/petalogix_s3adsp1800_mmu.c
> +include/hw/char/xilinx_uartlite.h

Missing the leading "F: " ?

>  petalogix_ml605
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>

thanks
-- PMM
