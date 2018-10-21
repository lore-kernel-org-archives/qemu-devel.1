Received: from eggs.gnu.org ([2001:4830:134:3::10]:45565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDmt-0007u3-LR
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDmt-0007qV-1v
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:28:59 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:52343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDms-0007qF-Mm
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:28:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id 189-v6so7666872wmw.2
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:28:58 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-33-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4b050e39-46b1-9c75-6e4c-70b4ba98e873@linaro.org>
Date: Sun, 21 Oct 2018 14:28:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-33-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 32/56] sh4: convert to
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 10/19/18 2:06 AM, Emilio G. Cota wrote:
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/sh4/cpu.c    | 2 +-
>  target/sh4/helper.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
