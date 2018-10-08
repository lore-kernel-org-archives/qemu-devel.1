Received: from eggs.gnu.org ([2001:4830:134:3::10]:51560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9SZ7-0001XN-Sm
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 06:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9SZ7-00027I-2s
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 06:15:05 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9SZ6-00026t-Tj
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 06:15:05 -0400
Received: by mail-oi1-x244.google.com with SMTP id e17-v6so15334861oib.4
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 03:15:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181005175350.30752-1-richard.henderson@linaro.org>
References: <20181005175350.30752-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 11:14:43 +0100
Message-ID: <CAFEAcA-tC__kyNie_TrfFe6PVzcExbXU-DnK5fDXcG=WqS+Ftw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/15] target/arm: sve system mode
 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 October 2018 at 18:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> For v3, the only change is to patch 4, which is also the only
> patch without a reviewed-by tag.
>
> I now check for aa64 state before checking for sve length, and
> added a comment about why it is important to play with sve when
> transitioning into aa32 state.
>
>
> r~
>



Applied to target-arm.next, thanks.

-- PMM
