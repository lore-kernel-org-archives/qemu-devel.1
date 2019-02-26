Received: from eggs.gnu.org ([209.51.188.92]:57474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gybnl-0000Oe-0M
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gybng-00089F-Ul
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:25:35 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gybna-000864-Ep
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:25:28 -0500
Received: by mail-oi1-x243.google.com with SMTP id j135so10139353oib.13
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 04:25:21 -0800 (PST)
MIME-Version: 1.0
References: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
In-Reply-To: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 12:25:10 +0000
Message-ID: <CAFEAcA9G73yrRvj3AdyxAi2uUBH9GPPerwi7y38oMDKw8F0B=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Added periodic IRQ support for
 bcm2836_control local timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bzt <bztemail@gmail.com>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 26 Feb 2019 at 11:38, bzt <bztemail@gmail.com> wrote:
>
> Dear qemu developers,
>
> Honestly SubmitAPatch is a bit complicated for me, so I'm hoping I've
> done everything right. To be sure, you can find my patch here:
> https://github.com/bztsrc/qemu-local-timer and diff against the latest
> github repo here:
> https://github.com/bztsrc/qemu-local-timer/blob/patches/3.1.50.diff

Thanks for the patch. You've got the most important things
right -- patch sent as an email, and with a Signed-off-by:
line from you. I've put this on my to-review queue, and I
should be able to get to it within a week or so.

thanks
-- PMM
