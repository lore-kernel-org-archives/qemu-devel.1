Received: from eggs.gnu.org ([2001:4830:134:3::10]:41899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eACT3-0001Bl-LV
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eACT2-0003JS-Lx
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:11:21 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:48603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eACT2-0003Im-Et
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:11:20 -0400
Received: by mail-wm0-x235.google.com with SMTP id p75so9844784wmg.3
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 03:11:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171031175037.GB29920@kentang.lan>
References: <20171031175037.GB29920@kentang.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 10:10:58 +0000
Message-ID: <CAFEAcA8RNEXZ+fehTTqvTacsiL49j8gA1vypWQUq=Xk9LB7tUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] qemu-sparc update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 October 2017 at 17:50, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> Here are the last set of changes for 2.11 which is the tidy up of the sun4m DMA
> devices along with the switch from the legacy sun4m IOMMU API to an IOMMU
> memory region instead. Please pull.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit 7fa00e204902cee0b33a0c60de87e87319d1809f:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20171031' into staging (2017-10-31 14:28:25 +0000)
>
> are available in the git repository at:
>
>
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-signed
>
> for you to fetch changes up to badd3d62c619d24a5af62198374f42b7c510ee41:
>
>   sun4m: change TYPE_SUN4M_IOMMU macro from "iommu" to "sun4m-iommu" (2017-10-31 17:25:37 +0000)
>
> ----------------------------------------------------------------
> qemu-sparc update

Applied, thanks.

-- PMM
