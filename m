Received: from eggs.gnu.org ([2001:4830:134:3::10]:51075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erNO7-0006Xs-46
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erNO6-0005ud-9v
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:32:43 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:40593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erNO6-0005uI-44
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 07:32:42 -0500
Received: by mail-ot0-x242.google.com with SMTP id l12so5380912otj.7
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 04:32:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180227191613.bgnl27q237j7quoz@kentang.home>
References: <20180227191613.bgnl27q237j7quoz@kentang.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 12:32:20 +0000
Message-ID: <CAFEAcA-rq4wjprM=MUXh2dxbkVdqyaq6W6gqKWqviq1G2Jbb4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2018 at 19:16, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> Here is a pull request containing the loader fix which enables qemu-system-sparc to work when
> used with -kernel again.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit 3ec7b5d819da9245dd37a6f7e7d150f064cf584c:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180227-pull-request' into staging (2018-02-27 14:01:19 +0000)
>
> are available in the git repository at:
>
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-signed
>
> for you to fetch changes up to ca316c11526a1bc221fb542bdce6bac7238dde69:
>
>   loader: don't perform overlapping address check for memory region ROM images (2018-02-27 18:57:14 +0000)
>
> ----------------------------------------------------------------
> qemu-sparc update
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (1):
>       loader: don't perform overlapping address check for memory region ROM images
>
>  hw/core/loader.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)


Applied, thanks.

-- PMM
