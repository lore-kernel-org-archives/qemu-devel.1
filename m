Received: from eggs.gnu.org ([2001:4830:134:3::10]:40993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDW4-0001iz-Nl
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDW0-00048T-JI
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:11:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDVu-00041R-PE
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:11:29 -0400
Received: by mail-wm1-x32d.google.com with SMTP id y144-v6so7651195wmd.4
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:11:22 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-22-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a78d9b7f-c9ab-6bd0-a1e3-ddfaf2373eff@linaro.org>
Date: Sun, 21 Oct 2018 14:11:16 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-22-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 21/56] openrisc: convert to cpu_halted
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

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/openrisc/sys_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
