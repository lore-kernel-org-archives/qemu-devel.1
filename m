Received: from eggs.gnu.org ([209.51.188.92]:35967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1HQR-0004Wg-5t
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1HQN-0004ry-1S
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:16:32 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:39559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1HQG-0004dS-1c
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 16:16:27 -0500
Received: by mail-pf1-x433.google.com with SMTP id i20so6654802pfo.6
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 13:16:20 -0800 (PST)
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-6-mark.cave-ayland@ilande.co.uk>
	<dac4fce0-f063-5d41-1fc5-66e1eeac3c2c@linaro.org>
	<a1ffd292-ffd6-0458-7f25-daf064273186@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <19f4a3e9-d58f-b4af-e402-c36100707c38@linaro.org>
Date: Tue, 5 Mar 2019 13:16:16 -0800
MIME-Version: 1.0
In-Reply-To: <a1ffd292-ffd6-0458-7f25-daf064273186@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/8] target/ppc: introduce avr_offset()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 3/5/19 9:16 AM, Mark Cave-Ayland wrote:
> Really though I don't feel too strongly about this, so would you like me to
> rename it avr_full_offset() to match the existing vsr_full_offset()?
I do think matching the names makes things clearer.


r~
