Received: from eggs.gnu.org ([209.51.188.92]:47983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkBsF-0007CQ-TD
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkBsF-0004o0-7w
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:54:39 -0500
References: <20190117161355.18204-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4549a7e4-2ef2-6a53-1b06-cb89913b6d06@redhat.com>
Date: Thu, 17 Jan 2019 18:54:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190117161355.18204-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Fix utf-8 mangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 17/01/19 17:13, Philippe Mathieu-Daud=C3=A9 wrote:
> Patch incorrectly applied as 15ffb43cbf4.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Paolo can this be a patchew bug?

I tried reapplying the patch and it didn't have the issue, so it should
be fine.

Unicode is hard...

Paolo

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af339b86db..fd3d4de3fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1639,7 +1639,7 @@ F: include/hw/display/edid.h
>  F: qemu-edid.c
> =20
>  Firmware configuration (fw_cfg)
> -M: Philippe Mathieu-Daud=C3=83=C2=A9 <philmd@redhat.com>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>  R: Laszlo Ersek <lersek@redhat.com>
>  R: Gerd Hoffmann <kraxel@redhat.com>
>  S: Supported
>=20
