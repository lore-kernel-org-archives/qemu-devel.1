Received: from eggs.gnu.org ([209.51.188.92]:54702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBvQ6-0004fT-SD
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 02:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBvQ4-00086u-Vz
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 02:00:14 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBvQ1-0007xw-Hc
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 02:00:11 -0400
Received: by mail-ot1-x343.google.com with SMTP id j10so1296507otq.0
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 23:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <1554321185-2825-1-git-send-email-sandra@codesourcery.com>
	<1554321185-2825-3-git-send-email-sandra@codesourcery.com>
In-Reply-To: <1554321185-2825-3-git-send-email-sandra@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2019 12:59:56 +0700
Message-ID: <CAFEAcA_ENtYbEcxqH7LFDXS53-v3QiEYcn3aQ+Wh0MRGBcugDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 2/2] Add Nios II semihosting support.
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

On Thu, 4 Apr 2019 at 02:53, Sandra Loosemore <sandra@codesourcery.com> wrote:
>
> This patch adds support for libgloss semihosting to Nios II bare-metal
> emulation.  The specification for the protocol can be found in the
> libgloss sources.
>
> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
> Signed-off-by: Julian Brown <julian@codesourcery.com>

I gave a reviewed-by tag for this patch in v6 -- has something changed
in v7 that made that no longer able to carry across?

thanks
-- PMM
