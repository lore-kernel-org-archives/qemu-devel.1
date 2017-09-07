Received: from eggs.gnu.org ([2001:4830:134:3::10]:51916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpzkd-0001q5-Tw
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpzkZ-0005ev-AF
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:33:59 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:38109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpzkZ-0005eH-3J
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:33:55 -0400
Received: by mail-wr0-x232.google.com with SMTP id 108so432469wra.5
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 09:33:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPSm4UHL7K0ZBGF28Z+wZ0qtMLd7CSvF9W94LwsXfN9zQ@mail.gmail.com>
References: <cover.1504222314.git.alistair.francis@xilinx.com>
	<CAFEAcA8TSpNkz3ew+wk6K0vu18B5RCr=0vbkihcaDz8v2zUN8g@mail.gmail.com>
	<CAKmqyKMd0JcEtkqiajLd5sbWP9WpjS8XqwfGGWPuANchE5Ej3A@mail.gmail.com>
	<CAKmqyKPSm4UHL7K0ZBGF28Z+wZ0qtMLd7CSvF9W94LwsXfN9zQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 17:33:33 +0100
Message-ID: <CAFEAcA_0FyFFqJ2GOtUw5CPBKTj1YR9ykroyL-7WCYfbgR0hAg@mail.gmail.com>
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
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 7 September 2017 at 17:29, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> It looks like patch 1 and 3 still didn't make it through. I see them
> leaving the corporate network and going through to my personal email.
>
> Can anyone see anything on the QEMU mail server side? Any logs might
> help me push IT to investigate.

Unfortunately we don't really have much visibility into what
the mail server is doing, because it's run by nongnu.org.
It does seem to have a habit of occasionally eating patches
(maybe it thinks they're spam or something).

thanks
-- PMM
