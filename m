Received: from eggs.gnu.org ([2001:4830:134:3::10]:46447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDqB-0001lb-LB
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDq3-0000mo-IH
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:32:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:35723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDq2-0000mB-G1
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:32:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id o17-v6so6972296wmh.0
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:32:13 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-43-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0e69bd04-9a99-873d-5e71-59ec47ff0c3a@linaro.org>
Date: Sun, 21 Oct 2018 14:32:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-43-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 42/56] sparc: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 10/19/18 2:06 AM, Emilio G. Cota wrote:
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  hw/sparc64/sparc64.c | 19 +++++++++++++------
>  target/sparc/cpu.c   |  2 +-
>  2 files changed, 14 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
