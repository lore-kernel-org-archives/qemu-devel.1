Received: from eggs.gnu.org ([209.51.188.92]:51100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmMmQ-0003kK-Qh
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:57:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmMmO-000477-RP
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:57:38 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:33000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmMmN-00045v-KH
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 12:57:35 -0500
Received: by mail-ot1-x32e.google.com with SMTP id i20so2748676otl.0
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 09:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20190122122048.10845-1-edgar.iglesias@gmail.com>
In-Reply-To: <20190122122048.10845-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Jan 2019 17:57:22 +0000
Message-ID: <CAFEAcA_7ELkkbt27qcqtuJixwamD84Dum+8WuXfUdtvAMTL_cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/3] Xilinx queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On Tue, 22 Jan 2019 at 12:21, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> The following changes since commit e56b86bc7735dd076939fa33a76e1ee9d5907e47:
>
>   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into staging (2019-01-21 19:19:47 +0000)
>
> are available in the Git repository at:
>
>   git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2019-01-22.for-upstream
>
> for you to fetch changes up to 2867a96ffb63fa363820e4b0110b96a06218068b:
>
>   target/microblaze: Add props enabling exceptions on failed bus accesses (2019-01-22 03:17:34 -0800)
>
> ----------------------------------------------------------------
> Pullreq 2019-01-22
>
> ----------------------------------------------------------------
> Edgar E. Iglesias (2):
>       hw/microblaze: s3adsp1800: Create an unimplemented GPIO area
>       target/microblaze: Add props enabling exceptions on failed bus accesses
>
> Peter Maydell (1):
>       target/microblaze: Switch to transaction_failed hook

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
