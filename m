Received: from eggs.gnu.org ([2001:4830:134:3::10]:56843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erRgw-00088U-5x
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:08:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erRgv-0007pz-Da
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:08:26 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erRgv-0007pr-7G
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:08:25 -0500
Received: by mail-ot0-x243.google.com with SMTP id m22so6205301otf.10
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:08:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180301112403.12487-1-peter.maydell@linaro.org>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 17:08:03 +0000
Message-ID: <CAFEAcA_8FyUxjAozpdfhbyKhssqhBSF3UXcikZ6Wagb5zpOgFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/42] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 1 March 2018 at 11:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> Arm queue -- I have more stuff pending but I prefer to push
> this first lot out and keep the pull below 50 patches.
> Most of this is Alex's FP16 support work.
>
> -- PMM
>
>
> The following changes since commit 6697439794f72b3501ee16bb95d16854f9981421:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180227-pull-request' into staging (2018-02-27 17:50:46 +0000)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180301
>
> for you to fetch changes up to c22e580c2ad1cccef582e1490e732f254d4ac064:
>
>   MAINTAINERS: Update my email address (2018-03-01 11:13:59 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * update MAINTAINERS for Alistair's new email address
>  * add Arm v8.2 FP16 arithmetic extension for linux-user
>  * implement display connector emulation for vexpress board
>  * xilinx_spips: Enable only two slaves when reading/writing with stripe
>  * xilinx_spips: Use 8 dummy cycles with the QIOR/QIOR4 commands
>  * hw: register: Run post_write hook on reset
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
