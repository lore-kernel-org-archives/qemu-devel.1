Received: from eggs.gnu.org ([209.51.188.92]:40551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL540-0002ES-VA
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL540-0008Av-5T
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:07:16 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL540-0008AN-1F
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:07:16 -0400
Received: by mail-oi1-x241.google.com with SMTP id l1so6204016oib.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190411161013.4514-1-clg@kaod.org>
In-Reply-To: <20190411161013.4514-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 13:07:03 +0100
Message-ID: <CAFEAcA-WeTRp0zs5Zu_g3uCjzXaqSf5-G3nyrxMn_n+fQAN08A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] aspeed: cleanups and extenstions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>

On Thu, 11 Apr 2019 at 17:10, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> Here is a series adding a couple of cleanups to the Aspeed SoCs to
> prepare ground for extensions and new SoCs.
>
> Thanks,
>
> C.
>
> C=C3=A9dric Le Goater (3):
>   aspeed: add a per SoC mapping for the interrupt space
>   aspeed: add a per SoC mapping for the memory space
>   aspeed: use sysbus_init_child_obj() to initialize children
>



Applied to target-arm.next, thanks.

-- PMM
