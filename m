Received: from eggs.gnu.org ([2001:4830:134:3::10]:39923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKkcN-0001pX-7T
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKkcL-00019W-GI
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:45:07 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKkcL-000199-7d
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:45:05 -0500
Received: by mail-ot1-x344.google.com with SMTP id n46so13891706otb.9
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 05:45:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1541528230-31817-1-git-send-email-thuth@redhat.com>
References: <1541528230-31817-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 13:44:43 +0000
Message-ID: <CAFEAcA9D6uGgppP3o3Jq_DvqWGNkNF8UXgRk_4yWfKS++ExMmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add an entry for the 'collie'
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

On 6 November 2018 at 18:17, Thomas Huth <thuth@redhat.com> wrote:
> There is no active maintainer, but since Peter is picking up
> patches via qemu-arm@nongnu.org, I think we could at least use
> "Odd Fixes" as status here.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0499e11..471cf72 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -592,6 +592,12 @@ F: hw/*/pxa2xx*
>  F: hw/misc/mst_fpga.c
>  F: include/hw/arm/pxa.h
>
> +Sharp SL-5500 (Collie) PDA
> +L: qemu-arm@nongnu.org
> +S: Odd Fixes
> +F: hw/arm/collie.c
> +F: hw/arm/strongarm*
> +
>  Stellaris
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org

Applied to target-arm.next with myself added as an M: contact, thanks.

-- PMM
