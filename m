Received: from eggs.gnu.org ([2001:4830:134:3::10]:46168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDp8-00013U-S0
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDp8-0000DO-4M
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:31:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:40419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDp7-0000CW-Rg
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:31:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id z204-v6so7717827wmc.5
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:31:17 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-42-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <18fc1e34-bf06-e13c-ccdb-b0d81df11e57@linaro.org>
Date: Sun, 21 Oct 2018 14:31:12 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-42-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 41/56] moxie: convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Anthony Green <green@moxielogic.com>

On 10/19/18 2:06 AM, Emilio G. Cota wrote:
> Cc: Anthony Green <green@moxielogic.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/moxie/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
