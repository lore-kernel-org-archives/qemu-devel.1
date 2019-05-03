Received: from eggs.gnu.org ([209.51.188.92]:34416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYLL-0002YD-Au
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYLK-0003ez-7T
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:35:15 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYLK-0003e1-26
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:35:14 -0400
Received: by mail-oi1-x242.google.com with SMTP id l203so4430735oia.3
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190430044036.1144-1-joel@jms.id.au>
	<20190430044036.1144-3-joel@jms.id.au>
In-Reply-To: <20190430044036.1144-3-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:35:02 +0100
Message-ID: <CAFEAcA9HsxWxRoNVy+fpm_PYdiB+Ei6k7bbLeG-qG+KXkG8vkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hw/arm/aspeed: Add RTC to SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 30 Apr 2019 at 05:41, Joel Stanley <joel@jms.id.au> wrote:
>
> All systems have an RTC.
>
> The IRQ is hooked up but the model does not use it at this stage. There
> is no guest code that uses it, so this limitation is acceptable.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
