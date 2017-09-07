Received: from eggs.gnu.org ([2001:4830:134:3::10]:39996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dpzFN-0004cu-G6
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dpzFI-00041q-Vd
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:01:41 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA8TSpNkz3ew+wk6K0vu18B5RCr=0vbkihcaDz8v2zUN8g@mail.gmail.com>
References: <cover.1504222314.git.alistair.francis@xilinx.com>
	<CAFEAcA8TSpNkz3ew+wk6K0vu18B5RCr=0vbkihcaDz8v2zUN8g@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 7 Sep 2017 09:01:04 -0700
Message-ID: <CAKmqyKMd0JcEtkqiajLd5sbWP9WpjS8XqwfGGWPuANchE5Ej3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Expose the secure and virt
 properties to the
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On Thu, Sep 7, 2017 at 5:51 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 1 September 2017 at 00:34, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>>
>> The EL2 and EL3 work is working well now and interanlly we now have
>> tests that expect to start in EL3 and transition through EL2 to EL1. To
>> make this easy to run let's expose the secure property to the machine
>> and also add a virt property that can enable EL2.
>>
>> This series also does some machine/name tidying up and makes the first
>> move to deprecating the EP108 machine, which was just an early access
>> development board.
>>
>> V2:
>>  - Add a virt option for setting EL2
>
> It looks like only patches 4 5 and the cover letter got through the
> mailing list server, so patches and patchwork don't have the whole
> thing. Could I ask you to try a resend?

Just re-sent now. Hopefully it works this time.

Thanks,
Alistair

>
> thanks
> -- PMM
