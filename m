Received: from eggs.gnu.org ([2001:4830:134:3::10]:48135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQbiq-0003Im-0V
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQbil-0003yH-I1
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:51:12 -0400
References: <20170629150308.22766-1-f4bug@amsat.org>
	<20170629150308.22766-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <47c69e2f-bbc2-0825-a7d3-e4292b20a22c@redhat.com>
Date: Thu, 29 Jun 2017 17:51:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170629150308.22766-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/5] MAINTAINERS: update TCG entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Yang Zhong <yang.zhong@intel.com>
Cc: qemu-trivial@nongnu.org

On 29.06.2017 17:03, Philippe Mathieu-Daud=C3=A9 wrote:
> moved in a9ded601..244f1441 to accel/
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 839f7ca063..06006fc7df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -84,14 +84,10 @@ M: Paolo Bonzini <pbonzini@redhat.com>
>  M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>  M: Richard Henderson <rth@twiddle.net>
>  S: Maintained
> -F: cpu-exec.c
> -F: cpu-exec-common.c
>  F: cpus.c
> -F: cputlb.c
>  F: exec.c
>  F: softmmu_template.h
> -F: translate-all.*
> -F: translate-common.c
> +F: accel/tcg/
>  F: include/exec/cpu*.h
>  F: include/exec/exec-all.h
>  F: include/exec/helper*.h

Reviewed-by: Thomas Huth <thuth@redhat.com>
