Received: from eggs.gnu.org ([2001:4830:134:3::10]:60968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eouhp-0006yC-Lx
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eouho-0001oF-Tr
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:30:53 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:40856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eouho-0001nN-PO
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 12:30:52 -0500
Received: by mail-oi0-x236.google.com with SMTP id c12so4274918oic.7
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 09:30:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-3-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 17:30:31 +0000
Message-ID: <CAFEAcA-PMKZX2D_T4RJ+htkPaTg9=MY2qrCMVmW5=kMAW9tLKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 02/67] target/arm: Introduce
 translate-a64.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Move some stuff that will be common to both translate-a64.c
> and translate-sve.c.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
