Received: from eggs.gnu.org ([2001:4830:134:3::10]:45665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDnO-00089M-Gv
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDnM-00081n-UA
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:29:30 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDnM-00081M-JL
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:29:28 -0400
Received: by mail-wr1-x435.google.com with SMTP id l6-v6so41629662wrt.1
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:29:27 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-34-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5890b1dc-a1b7-a1b3-7b77-b134b1507c63@linaro.org>
Date: Sun, 21 Oct 2018 14:29:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-34-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 33/56] cris: convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 10/19/18 2:06 AM, Emilio G. Cota wrote:
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/cris/cpu.c    | 2 +-
>  target/cris/helper.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
