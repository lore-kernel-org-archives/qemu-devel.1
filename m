Received: from eggs.gnu.org ([2001:4830:134:3::10]:47057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH6rm-0003Pa-Vv
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH6rm-0003ae-21
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:09:42 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH6rl-0003aR-T1
	for qemu-devel@nongnu.org; Fri, 11 May 2018 08:09:41 -0400
Received: by mail-oi0-x244.google.com with SMTP id b130-v6so4490051oif.12
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:09:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510222601.19944-4-laurent@vivier.eu>
References: <20180510222601.19944-1-laurent@vivier.eu>
	<20180510222601.19944-4-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 13:09:20 +0100
Message-ID: <CAFEAcA8Lwhp6_uw2piEirtn7RMBm+UJJDnnWyFtLQp3r2NMnrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/5] linux-user: move sparc/sparc64
 socket.h definitions to sparc/sockbits.h
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

On 10 May 2018 at 23:25, Laurent Vivier <laurent@vivier.eu> wrote:
> No code change.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
