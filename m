Received: from eggs.gnu.org ([2001:4830:134:3::10]:43228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDd7-0000VA-Kr
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDd4-0000cP-Fr
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:18:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:38309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDd4-0000c9-9U
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:18:50 -0400
Received: by mail-wr1-x435.google.com with SMTP id d10-v6so2413812wrs.5
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:18:50 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-29-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8cbbc149-2048-2b90-2211-2b31ce124073@linaro.org>
Date: Sun, 21 Oct 2018 14:18:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-29-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v3 28/56] openrisc: use cpu_reset_interrupt
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
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Cc: Stafford Horne <shorne@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/openrisc/sys_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
