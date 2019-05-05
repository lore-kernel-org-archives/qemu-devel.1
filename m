Received: from eggs.gnu.org ([209.51.188.92]:51257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNJVs-0005ON-BZ
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNJVr-0007rW-IT
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:57:16 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNJVr-0007qu-AZ
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:57:15 -0400
Received: by mail-pf1-x444.google.com with SMTP id u17so5395535pfn.7
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:57:15 -0700 (PDT)
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
	<20190504083638.13380-9-S.E.Harris@kent.ac.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c05b4876-c55e-fd82-46d0-83be1b128cee@linaro.org>
Date: Sun, 5 May 2019 08:57:11 -0700
MIME-Version: 1.0
In-Reply-To: <20190504083638.13380-9-S.E.Harris@kent.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target/avr: Register AVR support
 with the rest of QEMU, the build system, and the MAINTAINERS file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sarah Harris <S.E.Harris@kent.ac.uk>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, A.M.King@kent.ac.uk, E.J.C.Robbins@kent.ac.uk

On 5/4/19 1:36 AM, Sarah Harris wrote:
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
...
>  
> +AVR
> +M: Michael Rolnik <mrolnik@gmail.com>
> +S: Odd Fixes
> +F: target-avr/
> +F: hw/avr/
> +

This is not how things work.  Michael wasn't up to maintaining the code 2 years
ago; that's why it was never committed.

You would need to maintain this yourself, and for more than "Odd Fixes".


r~
