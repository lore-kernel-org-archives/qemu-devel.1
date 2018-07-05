Received: from eggs.gnu.org ([2001:4830:134:3::10]:50630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb6TG-00006g-16
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb6TF-0005DJ-BB
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:47:02 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb6TF-0005CB-6j
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:47:01 -0400
Received: by mail-oi0-x244.google.com with SMTP id i12-v6so17757873oik.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 08:47:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180630091343.14391-3-stefanha@redhat.com>
References: <20180630091343.14391-1-stefanha@redhat.com>
	<20180630091343.14391-3-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 16:46:40 +0100
Message-ID: <CAFEAcA9_nXBF6GWaQhp2K_s8c2dwjBQ+0HME5g_Og5FBcvERGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] hw/arm: add ARMv6M object
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
> The ARMv6M object will be used by machine types that need ARMv6-M CPUs.
>
> There is no logic beyond what the ARMMProfile base class already
> provides because ARMv6-M is a pretty small microcontroller without many
> bells and whistles.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
