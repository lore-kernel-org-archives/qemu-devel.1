Received: from eggs.gnu.org ([2001:4830:134:3::10]:47205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH6s2-0003oF-Hg
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH6s1-0003jw-KD
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:09:58 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH6s1-0003jl-GK
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:09:57 -0400
Received: by mail-ot0-x244.google.com with SMTP id i5-v6so5968440otf.1
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:09:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510222601.19944-5-laurent@vivier.eu>
References: <20180510222601.19944-1-laurent@vivier.eu>
	<20180510222601.19944-5-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 13:09:36 +0100
Message-ID: <CAFEAcA_VH_KwbJs_krZq88XRMDzxwc0wtM3_32grG-RjwXXEnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/5] linux-user: move ppc socket.h
 definitions to ppc/sockbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Richard Henderson <rth@twiddle.net>

On 10 May 2018 at 23:26, Laurent Vivier <laurent@vivier.eu> wrote:
> No code change.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
