Received: from eggs.gnu.org ([2001:4830:134:3::10]:46249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb6Be-0002Fw-8i
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb6Bd-0003YS-GQ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:28:50 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb6Bd-0003YB-A9
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:28:49 -0400
Received: by mail-oi0-x243.google.com with SMTP id w126-v6so17627485oie.7
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 08:28:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180630091343.14391-4-stefanha@redhat.com>
References: <20180630091343.14391-1-stefanha@redhat.com>
	<20180630091343.14391-4-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 16:28:28 +0100
Message-ID: <CAFEAcA88Hv=kd3QV+EsqfBXO9+v4G=YqPcHDBOXa1pR0UmN=-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] target/arm: add "cortex-m0" CPU
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Liviu Ionescu <ilg@livius.net>

On 30 June 2018 at 10:13, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Define a "cortex-m0" ARMv6-M CPU model.
>
> Most of the register reset values set by other CPU models are not
> relevant for the cut-down ARMv6-M architecture.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
