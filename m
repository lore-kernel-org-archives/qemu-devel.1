Received: from eggs.gnu.org ([209.51.188.92]:39122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW26-00048Z-WE
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLW0E-00011w-SH
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:53:11 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLW0E-00011W-Lx
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:53:10 -0400
Received: by mail-pf1-x441.google.com with SMTP id b3so7361894pfd.1
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:53:10 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-12-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <563644aa-8e79-8b46-61c0-3a10b62fbc28@linaro.org>
Date: Tue, 30 Apr 2019 09:53:01 -0700
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-12-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/14] target/ppc: decode target register
 in VSX_VECTOR_LOAD_STORE_LENGTH at translation time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/helper.h                 | 8 ++++----
>  target/ppc/mem_helper.c             | 6 ++----
>  target/ppc/translate/vsx-impl.inc.c | 7 ++++---
>  3 files changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
