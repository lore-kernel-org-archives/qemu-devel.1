Received: from eggs.gnu.org ([2001:4830:134:3::10]:41080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftCQ3-0006OL-6r
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftCQ2-0002G7-Af
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:46:31 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftCQ1-0002Fa-Sw
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:46:30 -0400
Received: by mail-oi0-x242.google.com with SMTP id p84-v6so15401386oic.4
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 06:46:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180824122851.4078-1-peter.maydell@linaro.org>
References: <20180824122851.4078-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 14:46:08 +0100
Message-ID: <CAFEAcA9EDUo0CBu=GyJF4C8k_CLs+P4jDEV7tBHOzMPFO_rmoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/52] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 24 August 2018 at 13:28, Peter Maydell <peter.maydell@linaro.org> wrote:
> target-arm queue: this clears out a bunch of patches I'd sent over
> the last coupled of weeks that have now got reviewed. Mostly
> this is MPS2 device support improvements, put there is also
> more of the incremental work towards supporting AArch32 Hyp mode,
> a floating point bugfix, and the raspi framebuffer viewport support.
>
> v2 fixes a "variable used uninitialized" error in a15mpcore.c.
>
> thanks
> -- PMM
>
>
> The following changes since commit 6b699ae1be9f257478d5eca7ef65dcea270a2796:
>
>   tests/vm: Increase timeout waiting for VM to boot to 5 minutes (2018-08-24 11:31:28 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180824-1
>
> for you to fetch changes up to 239cb6feb298a31faa40b7e97ced107bf9c2f2bf:
>
>   hw/arm/mps2: Fix ID register errors on AN511 and AN385 (2018-08-24 13:17:50 +0100)
>

Applied, thanks.

-- PMM
