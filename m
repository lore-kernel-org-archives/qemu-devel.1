Received: from eggs.gnu.org ([2001:4830:134:3::10]:46371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZhUO-0001T3-BK
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:22:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eZhUN-0003xD-EE
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:22:08 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:43221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eZhUN-0003we-7l
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:22:07 -0500
Received: by mail-wm0-x241.google.com with SMTP id g1so7310819wmg.2
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:22:06 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA8wXx6WVpD80Mta_otv3A9NXYhm=des3g1qV7NS0JmTuw@mail.gmail.com>
References: <b799d9d21170a492c54fb2c4eaf8326b06e0bdf6.1515523657.git.alistair.francis@xilinx.com>
	<CAFEAcA8wXx6WVpD80Mta_otv3A9NXYhm=des3g1qV7NS0JmTuw@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 11 Jan 2018 10:21:35 -0800
Message-ID: <CAKmqyKMyjTXxpxV8ZhOQMFXP0gcTAP893D024w7BH2C7XCBZtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/3] xlnx-zynqmp-rtc: Initial commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On Thu, Jan 11, 2018 at 3:57 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 9 January 2018 at 18:50, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> Initial commit of the ZynqMP RTC device.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>
> Hi -- did you forget to send the cover letter for this series, or
> did the mailing list server drop it? I only see the 3 patch mails...

I did forget. I didn't want to send a new version out straight away so
I was going to wait on comments before sending a v2 with a cover
letter.

Alistair

>
> thanks
> -- PMM
