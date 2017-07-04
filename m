Received: from eggs.gnu.org ([2001:4830:134:3::10]:34911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dSNPz-0002TU-C6
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dSNPy-0002t2-Gz
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:59:03 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:32881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dSNPy-0002sh-9G
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:59:02 -0400
Received: by mail-wm0-x231.google.com with SMTP id z75so44567274wmc.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 05:59:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
References: <1499162088-1562-1-git-send-email-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2017 13:58:40 +0100
Message-ID: <CAFEAcA-DC9-2NBLGEwJtXcpY490P=qpudOau0o=6LMT=Tn3tHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 00/17] Xilinx queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, alistai@xilinx.com, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 4 July 2017 at 10:54, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> The following changes since commit fd479c60f5766f7fb247ad146b9e3c33d03d2055:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170603' into staging (2017-07-03 09:54:32 +0100)
>
> are available in the git repository at:
>
>   git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next.for-upstream
>
> for you to fetch changes up to 31cf950ea2a010c33e5384aaba91f01dc27c1599:
>
>   xilinx-dp: Add support for the yuy2 video format (2017-07-04 09:22:20 +0200)
>
> ----------------------------------------------------------------
> edgar/xilinx-next.for-upstream
>
> ----------------------------------------------------------------
> Edgar E. Iglesias (16):
>       target-microblaze: Correct bit shift for the PVR0 version field
>       target-microblaze: Don't hard code 0xb as initial MB version
>       target-microblaze: Add CPU versions 9.4, 9.5 and 9.6
>       target-microblaze: Introduce a use-barrel property
>       target-microblaze: Introduce a use-div property
>       target-microblaze: Introduce a use-hw-mul property
>       target-microblaze: Introduce a use-msr-instr property
>       target-microblaze: Introduce a use-pcmp-instr property
>       target-microblaze: dec_barrel: Use bool instead of unsigned int
>       target-microblaze: dec_barrel: Use extract32
>       target-microblaze: dec_barrel: Add braces around if-statements
>       target-microblaze: dec_barrel: Plug TCG temp leak
>       target-microblaze: dec_barrel: Add BSEFI
>       target-microblaze: dec_barrel: Add BSIFI
>       target-microblaze: Add CPU version 10.0
>       xilinx-dp: Add support for the yuy2 video format
>
> Stefan Weil (1):
>       disas/microblaze: Add missing 'const' attributes


Applied, thanks.

-- PMM
