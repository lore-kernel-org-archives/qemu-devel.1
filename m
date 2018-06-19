Received: from eggs.gnu.org ([2001:4830:134:3::10]:33247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVEvv-0002NI-OO
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVEvs-0006RT-LP
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:36:23 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:60704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVEvs-00068X-C9
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 07:36:20 -0400
References: <1529346580-25537-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Yongbok Kim <yongbok.kim@mips.com>
Message-ID: <33eb9ed9-fab0-faec-ef3d-57e4efa564b6@mips.com>
Date: Tue, 19 Jun 2018 12:35:24 +0100
MIME-Version: 1.0
In-Reply-To: <1529346580-25537-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: update target-mips maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net, rich.fuhler@mips.com, petar.jovanovic@mips.com, aleksandar.markovic@mips.com

On 18/06/2018 19:29, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@mips.com>
>
> Yongbok Kim transfers duties of QEMU for target MIPS maintainer to
> myself as he leaves MIPS. Many thanks to Yongbok for his substantial
> contributing to QEMU for MIPS over many years and taking care of its
> maintainance for almost two years.
>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>   MAINTAINERS | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0fb5f38..b81a93b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -185,7 +185,7 @@ F: disas/microblaze.c
>   
>   MIPS
>   M: Aurelien Jarno <aurelien@aurel32.net>
> -M: Yongbok Kim <yongbok.kim@mips.com>
> +M: Aleksandar Markovic <aleksandar.markovic@mips.com>
>   S: Maintained
>   F: target/mips/
>   F: hw/mips/
> @@ -696,7 +696,7 @@ S: Maintained
>   F: hw/mips/mips_malta.c
>   
>   Mipssim
> -M: Yongbok Kim <yongbok.kim@mips.com>
> +M: Aleksandar Markovic <aleksandar.markovic@mips.com>
>   S: Odd Fixes
>   F: hw/mips/mips_mipssim.c
>   F: hw/net/mipsnet.c
> @@ -707,7 +707,7 @@ S: Maintained
>   F: hw/mips/mips_r4k.c
>   
>   Fulong 2E
> -M: Yongbok Kim <yongbok.kim@mips.com>
> +M: Aleksandar Markovic <aleksandar.markovic@mips.com>
>   S: Odd Fixes
>   F: hw/mips/mips_fulong2e.c
>   F: hw/isa/vt82c686.c

Thanks Aleksandar.
Can you send this patch with your mips.com account again?
Otherwise,
Acked-by: Yongbok Kim <yongbok.kim@mips.com>
