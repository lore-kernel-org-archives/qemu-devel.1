Received: from eggs.gnu.org ([209.51.188.92]:34900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3MNG-000590-7D
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h3MC2-0005pG-11
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:46:18 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:47031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h3MC1-0005oe-Pd
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:46:17 -0400
Received: by mail-pg1-x542.google.com with SMTP id a22so4192126pgg.13
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 07:46:17 -0700 (PDT)
References: <20190310003428.11723-1-f4bug@amsat.org>
	<20190310003428.11723-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <96da5372-855f-720c-9958-5ad7461ab67f@linaro.org>
Date: Mon, 11 Mar 2019 07:46:12 -0700
MIME-Version: 1.0
In-Reply-To: <20190310003428.11723-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6] target/m68k: Reduce the l1 TCGLabel
 scope
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org

On 3/9/19 4:34 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/m68k/translate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
