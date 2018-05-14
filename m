Received: from eggs.gnu.org ([2001:4830:134:3::10]:37416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIDuV-0000Sf-OO
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIDuT-0007mr-NR
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:53:06 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:42612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIDuT-0007mW-In
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:53:05 -0400
Received: by mail-ot0-x233.google.com with SMTP id l13-v6so14337904otk.9
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 06:53:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512004311.9299-13-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
	<20180512004311.9299-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 14:52:44 +0100
Message-ID: <CAFEAcA8eOJ93SubeHY0F3mqZ+Zad3THUPoJEb_F2=BZ==zfCQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 12/27] target/arm: Use
 floatX_silence_nan when we have already checked for SNaN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 12 May 2018 at 01:42, Richard Henderson <richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.c |  6 +++---
>  target/arm/helper.c     | 12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
