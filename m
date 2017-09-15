Received: from eggs.gnu.org ([2001:4830:134:3::10]:37039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsutx-0004My-NL
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsutw-0008G3-VM
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:59:41 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:46934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsutw-0008Fl-Oo
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:59:40 -0400
Received: by mail-wm0-x231.google.com with SMTP id i189so10262903wmf.1
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 10:59:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
References: <1505411573-27848-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Sep 2017 18:59:18 +0100
Message-ID: <CAFEAcA8neyf851L2RjTWEWq8_oGzN0X4OFt_2kNOt6BWU8KpsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/18] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 14 September 2017 at 18:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> ARM queue: nothing particularly exciting, but 18 patches
> is enough to send out.
>
> thanks
> -- PMM
>
> The following changes since commit 3dabde1128b671f36ac6cb36b97b273139964420:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170914' into staging (2017-09-14 16:33:02 +0100)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170914
>
> for you to fetch changes up to ce3bc112cdb1d462e2d52eaa17a7314e7f3af504:
>
>   mps2-an511: Fix wiring of UART overflow interrupt lines (2017-09-14 18:43:19 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * v7M: various code cleanups
>  * v7M: set correct BFSR bits on bus fault
>  * v7M: clear exclusive monitor on reset and exception entry/exit
>  * v7M: don't apply priority mask to negative priorities
>  * zcu102: support 'secure' and 'virtualization' machine properties
>  * aarch64: fix ERET single stepping
>  * gpex: implement PCI INTx routing
>  * mps2-an511: fix UART overflow interrupt line wiring
>

Applied, thanks.

-- PMM
