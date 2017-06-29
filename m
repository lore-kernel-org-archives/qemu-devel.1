Received: from eggs.gnu.org ([2001:4830:134:3::10]:38777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dQbIz-0001sO-Ow
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dQbIx-0000Iz-5e
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:24:29 -0400
References: <20170629150308.22766-1-f4bug@amsat.org>
	<20170629150308.22766-5-f4bug@amsat.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <8e5fee51-a858-61d5-a10d-8f7e803d6a97@weilnetz.de>
Date: Thu, 29 Jun 2017 17:24:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170629150308.22766-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] MAINTAINERS: update TCI entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Yang Zhong <yang.zhong@intel.com>
Cc: qemu-trivial@nongnu.org

Am 29.06.2017 um 17:03 schrieb Philippe Mathieu-Daud=C3=A9:
> moved in 244f1441 to tcg/
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 530293044b..9bad523060 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1654,7 +1654,7 @@ TCI target
>  M: Stefan Weil <sw@weilnetz.de>
>  S: Maintained
>  F: tcg/tci/
> -F: tci.c
> +F: tcg/tci.c
>  F: disas/tci.c
> =20
>  Block drivers


Thank you for this fix.

Reviewed-by: Stefan Weil <sw@weilnetz.de>
