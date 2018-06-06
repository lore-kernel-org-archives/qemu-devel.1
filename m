Received: from eggs.gnu.org ([2001:4830:134:3::10]:57853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQZoE-0000Pt-LT
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQZoD-000441-RE
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:53:10 -0400
References: <20180606144706.29732-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1160f838-5625-b9bf-6c34-3071ed185074@redhat.com>
Date: Wed, 6 Jun 2018 16:53:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180606144706.29732-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Adopt the Gumstix
 computers-on-module machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 06.06.2018 16:47, Philippe Mathieu-Daud=C3=A9 wrote:
> These COMs are hard to find, and the companie dropped the support
> few years ago.
>=20
> Per the "Gumstix Product Changes, Known Issues, and EOL" pdf:
>=20
> - Phasing out: PXA270-based Verdex product line
>   September 2012
>=20
> - Phasing out: PXA255-based Basix & Connex
>   September 2009
>=20
> However there are still booting SD card image availables, very
> convenient to stress test the QEMU SD card implementation.
> Therefore I volunteer to keep an eye on this file, while it
> is useful for testing.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41cd3736a9..1825deb762 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -491,9 +491,10 @@ F: include/hw/arm/digic.h
>  F: hw/*/digic*
> =20
>  Gumstix
> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>  L: qemu-devel@nongnu.org
>  L: qemu-arm@nongnu.org
> -S: Orphan
> +S: Odd Fixes
>  F: hw/arm/gumstix.c

Great! So we can also remove the Gumstix entries from
https://wiki.qemu.org/Features/LegacyRemoval ?

 Thomas
