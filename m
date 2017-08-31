Received: from eggs.gnu.org ([2001:4830:134:3::10]:40630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnHwY-0002Q6-Ri
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnHwY-0003jH-5I
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:23:06 -0400
References: <20170830215523.25278-1-f4bug@amsat.org>
	<20170830215523.25278-3-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3b185bc6-d5ea-85dc-8635-e9d21914d011@redhat.com>
Date: Thu, 31 Aug 2017 07:22:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170830215523.25278-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/17] MAINTAINERS: add missing
 Versatile PB entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

On 30.08.2017 23:55, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b363e1b9c9..5b7891addc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -515,6 +515,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: hw/*/versatile*
> +F: hw/misc/arm_sysctl.c

I think you could also merge this into the previous patch. Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
