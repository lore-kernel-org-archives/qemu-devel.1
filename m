Received: from eggs.gnu.org ([2001:4830:134:3::10]:43550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gR3Fh-0001NN-Bu
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 17:51:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gR3Fg-0001Z3-5N
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 17:51:45 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gR3Ff-0001Xe-SL
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 17:51:44 -0500
Received: by mail-ot1-x342.google.com with SMTP id e12so10629819otl.5
	for <qemu-devel@nongnu.org>; Sun, 25 Nov 2018 14:51:42 -0800 (PST)
MIME-Version: 1.0
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-17-philmd@redhat.com>
In-Reply-To: <20181125205000.10324-17-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Nov 2018 22:51:30 +0000
Message-ID: <CAFEAcA-9eazE0mhLA04JoUh6mwuiA3RVGVeeQrbYO9JwaEC-=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 16/25] MAINTAINERS: Add missing
 entries for the MPS2 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Sun, 25 Nov 2018 at 20:52, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Missed in de343bb632a.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e04f2f1a44..2795135a09 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -587,6 +587,8 @@ F: hw/misc/mps2-*.c
>  F: include/hw/misc/mps2-*.h
>  F: hw/arm/iotkit.c
>  F: include/hw/arm/iotkit.h
> +F: hw/misc/iotkit-secctl.c
> +F: include/hw/misc/iotkit-secctl.h
>  F: hw/misc/iotkit-sysctl.c
>  F: include/hw/misc/iotkit-sysctl.h
>  F: hw/misc/iotkit-sysinfo.c
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
