Received: from eggs.gnu.org ([2001:4830:134:3::10]:54102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJkQh-0005zf-0G
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJkQg-00080m-9b
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:48:39 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:44504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJkQg-00080h-3z
	for qemu-devel@nongnu.org; Fri, 18 May 2018 14:48:38 -0400
Received: by mail-ot0-x236.google.com with SMTP id g7-v6so10239561otj.11
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 11:48:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 19:48:16 +0100
Message-ID: <CAFEAcA_+0gfKh_A_6JDT1tF3F3axvD675hp27Z_rRL+5g8z97A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/32] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 18 May 2018 at 18:19, Peter Maydell <peter.maydell@linaro.org> wrote:
> Another target-arm queue, since we're over 30 patches
> already. Most of this is RTH's SVE-patches-part-1.
>
> thanks
> -- PMM
>
>
> The following changes since commit d32e41a1188e929cc0fb16829ce3736046951e39:
>
>   Merge remote-tracking branch 'remotes/famz/tags/docker-and-block-pull-request' into staging (2018-05-18 14:11:52 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180518
>
> for you to fetch changes up to b94f8f60bd841c5b737185cd38263e26822f77ab:
>
>   target/arm: Implement SVE Permute - Extract Group (2018-05-18 17:48:09 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Initial part of SVE implementation (currently disabled)
>  * smmuv3: fix some minor Coverity issues
>  * add model of Xilinx ZynqMP generic DMA controller
>  * expose (most) Arm coprocessor/system registers to
>    gdb via QEMU's gdbstub, for reads only
>

Applied, thanks.

-- PMM
