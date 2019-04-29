Received: from eggs.gnu.org ([209.51.188.92]:39011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8co-0007RT-G1
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8cn-0007a5-60
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:55:26 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL8cn-0007ZO-1d
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:55:25 -0400
Received: by mail-ot1-x341.google.com with SMTP id a10so253272otl.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <1554321185-2825-1-git-send-email-sandra@codesourcery.com>
In-Reply-To: <1554321185-2825-1-git-send-email-sandra@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 16:55:13 +0100
Message-ID: <CAFEAcA_X+rmREYo_HRjKwwNmUGG4vEeb6s=5eLb3MudmEsUH=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 0/2] Nios II generic board config and
 semihosting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandra Loosemore <sandra@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>

On Wed, 3 Apr 2019 at 20:53, Sandra Loosemore <sandra@codesourcery.com> wrote:
>
> This is the seventh version of the patch series last posted here:
> http://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg06255.html
>
> Changes since v6:
> - Fixed block comment formatting for QEMU style.
> - Fixed fixme for interrupt handler (now added to libgloss BSP).
> - Added link to libgloss semihosting documentation.
>
> Sandra Loosemore (2):
>   Add generic Nios II board.
>   Add Nios II semihosting support.

Since Nios II doesn't have anybody actively handling
pull requests for it right now, I've applied these patches
directly to master -- thanks!

-- PMM
