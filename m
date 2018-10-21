Received: from eggs.gnu.org ([2001:4830:134:3::10]:46529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDqT-00022J-3z
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDqO-0000wP-Jl
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:32:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:46057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDqO-0000vO-Bv
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:32:36 -0400
Received: by mail-wr1-x431.google.com with SMTP id f17-v6so10266446wrs.12
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:32:36 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-44-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0cdfd4d3-51c3-9a18-36a5-1742b08de2aa@linaro.org>
Date: Sun, 21 Oct 2018 14:32:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-44-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 43/56] openrisc: convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>

On 10/19/18 2:06 AM, Emilio G. Cota wrote:
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  hw/openrisc/cputimer.c | 2 +-
>  target/openrisc/cpu.c  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
