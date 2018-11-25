Received: from eggs.gnu.org ([2001:4830:134:3::10]:43262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gR3F7-0000sw-HX
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 17:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gR3F6-00010i-JC
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 17:51:09 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gR3F6-0000zj-Ec
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 17:51:08 -0500
Received: by mail-ot1-x341.google.com with SMTP id a11so14913068otr.10
	for <qemu-devel@nongnu.org>; Sun, 25 Nov 2018 14:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-16-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-16-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Nov 2018 22:50:56 +0000
Message-ID: <CAFEAcA8ynuCc3RGcGGLc=aKB-DRiVr2joo7BjDNHf_TvXmuRDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 15/25] MAINTAINERS: Add missing
 entries for the Canon DIGIC machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Sun, 25 Nov 2018 at 20:52, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> This pattern now also matches:
> - include/hw/timer/digic-timer.h
> - include/hw/char/digic-uart.h
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eab0fb9742..e04f2f1a44 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -527,6 +527,7 @@ L: qemu-arm@nongnu.org
>  S: Odd Fixes
>  F: include/hw/arm/digic.h
>  F: hw/*/digic*
> +F: include/hw/*/digic*
>
>  Gumstix
>  M: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
