Received: from eggs.gnu.org ([2001:4830:134:3::10]:40510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3lt-0001OT-4K
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3lm-0004qO-OQ
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:11:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:36475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3lf-0004mH-0Y
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:11:19 -0400
Received: by mail-wr1-x42c.google.com with SMTP id y16so1730260wrw.3
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:11:18 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-39-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <02b390c3-038b-b579-9e49-96ba74eb78e4@linaro.org>
Date: Fri, 26 Oct 2018 16:11:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-39-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 39/71] i386/hax-all: convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/i386/hax-all.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
