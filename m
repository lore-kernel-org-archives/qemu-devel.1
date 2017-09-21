Received: from eggs.gnu.org ([2001:4830:134:3::10]:47098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dv5Hf-0001x0-1O
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dv5He-0001zq-4r
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:29:07 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:51178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dv5Hd-0001yc-SU
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 13:29:06 -0400
Received: by mail-wr0-x22b.google.com with SMTP id w12so5123806wrc.7
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 10:29:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
References: <1506012099-13605-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 18:28:43 +0100
Message-ID: <CAFEAcA_wuqP7CqFv9=MsujoXOaRfd0rR2x93tSz0JgZAQpP0Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/31] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 21 September 2017 at 17:41, Peter Maydell <peter.maydell@linaro.org> wrote:
> ARM queue: mostly patches from me, but also the Smartfusion2 board.
>
> thanks
> -- PMM
>
> The following changes since commit 9ee660e7c138595224b65ddc1c5712549f0a278c:
>
>   Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170921' into staging (2017-09-21 14:40:32 +0100)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170921
>
> for you to fetch changes up to 6d262dcb7d108eda93813574c2061398084dc795:
>
>   msf2: Add Emcraft's Smartfusion2 SOM kit (2017-09-21 16:36:56 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * more preparatory work for v8M support
>  * convert some omap devices away from old_mmio
>  * remove out of date ARM ARM section references in comments
>  * add the Smartfusion2 board

Applied, thanks.

-- PMM
