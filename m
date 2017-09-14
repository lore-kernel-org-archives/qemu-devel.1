Received: from eggs.gnu.org ([2001:4830:134:3::10]:38283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dsarC-0000QE-Rz
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 16:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dsarB-0001oX-VO
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 16:35:30 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA-A78rWzUeBh3M_k2SUmu3A8LwROQKCmw78D8PyE2neJA@mail.gmail.com>
References: <cover.1504293917.git.alistair.francis@xilinx.com>
	<26b702658b5bf9984edaecb22b1190be0a9d7052.1504293917.git.alistair.francis@xilinx.com>
	<CAFEAcA-A78rWzUeBh3M_k2SUmu3A8LwROQKCmw78D8PyE2neJA@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Sep 2017 13:34:57 -0700
Message-ID: <CAKmqyKOYqQeu31Ewb8E1AKKAeaG2kBgmwMGUxne_6yVxTKtQsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/6] aarch64-softmmu.mak: Use an ARM
 specific config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Sep 14, 2017 at 5:50 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 1 September 2017 at 22:00, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> In preperation for having an ARM and MicroBlaze ZynqMP machine let's
>> split out the current ARM specific config options.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>
> Acked-by: Peter Maydell <peter.maydell@linaro.org>

Thanks Peter.

>
> I'm assuming this series is going be reviewed and go into
> master via a microblaze tree, not the arm one...

I talked to Edgar and that is the plan.

Thanks,
Alistair

>
> thanks
> -- PMM
