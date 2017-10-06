Received: from eggs.gnu.org ([2001:4830:134:3::10]:42854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0T0L-0001bW-Mp
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0T0H-00063Q-Tl
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:49:29 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:46773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0T0H-00062H-N1
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:49:25 -0400
Received: by mail-wr0-x236.google.com with SMTP id z1so4283685wre.3
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:49:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170918195100.17593-4-andrew.smirnov@gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-4-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 14:49:04 +0100
Message-ID: <CAFEAcA9zZqG1m5h4FP9NpXYES6uSz3uMwbmNx3XpLYsS6tQp2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 03/17] imx_fec: Refactor imx_eth_enable_rx()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 18 September 2017 at 20:50, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Refactor imx_eth_enable_rx() to have more meaningfull variable name
> than 'tmp' and to reduce number of logical negations done.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
