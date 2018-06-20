Received: from eggs.gnu.org ([2001:4830:134:3::10]:57084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVg3K-0006TP-81
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVg3H-0006iN-P6
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:33:48 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVg3H-0006i0-IV
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:33:47 -0400
Received: by mail-ot0-x244.google.com with SMTP id p95-v6so208527ota.5
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:33:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA97ZAfbstKJAcjSGoP20P3hao3-N7mG3EeGgtRLVeCcxg@mail.gmail.com>
References: <20180529124707.3025-1-edgar.iglesias@gmail.com>
	<20180620095000.mbhnrfmlnupzeig5@toto>
	<CAFEAcA97ZAfbstKJAcjSGoP20P3hao3-N7mG3EeGgtRLVeCcxg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 17:33:26 +0100
Message-ID: <CAFEAcA9UQtioX=+0uzPff83nOwoTdaHfcvYZN5gkpQtWOVsxYA@mail.gmail.com>
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

On 20 June 2018 at 11:02, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 20 June 2018 at 10:50, Edgar E. Iglesias <edgar.iglesias@xilinx.com> wrote:
>> On Tue, May 29, 2018 at 02:47:05PM +0200, Edgar E. Iglesias wrote:
>>> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>>>
>>> The ZynqMP actually has Cortex-R5Fs with the optional FPU enabled.
>>
>> Hi Peter,
>>
>> Any comments on this series?
>
> Oops, looks like it didn't make my to-review queue. I'll put it
> on the list...

...now applied to target-arm.next, thanks.

-- PMM
