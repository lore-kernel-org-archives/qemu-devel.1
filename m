Received: from eggs.gnu.org ([2001:4830:134:3::10]:54726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVZx9-0006bg-3Q
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVZx3-0006E7-JP
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:03:03 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVZx3-0006Dd-BU
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:02:57 -0400
Received: by mail-oi0-x242.google.com with SMTP id 14-v6so2498346oie.3
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 03:02:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180620095000.mbhnrfmlnupzeig5@toto>
References: <20180529124707.3025-1-edgar.iglesias@gmail.com>
	<20180620095000.mbhnrfmlnupzeig5@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 11:02:36 +0100
Message-ID: <CAFEAcA97ZAfbstKJAcjSGoP20P3hao3-N7mG3EeGgtRLVeCcxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] xlnx-zynqmp: Change the Cortex-R5
 for Cortex-R5F
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, Luc Michel <luc.michel@greensocs.com>, Stefano Stabellini <sstabellini@kernel.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 20 June 2018 at 10:50, Edgar E. Iglesias <edgar.iglesias@xilinx.com> wrote:
> On Tue, May 29, 2018 at 02:47:05PM +0200, Edgar E. Iglesias wrote:
>> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>>
>> The ZynqMP actually has Cortex-R5Fs with the optional FPU enabled.
>
> Hi Peter,
>
> Any comments on this series?

Oops, looks like it didn't make my to-review queue. I'll put it
on the list...

thanks
-- PMM
