Received: from eggs.gnu.org ([2001:4830:134:3::10]:45346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPdUo-0000vD-IB
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 19:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPdUj-0004AD-MX
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 19:32:42 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPdUj-00049y-Hc
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 19:32:37 -0400
Received: by mail-qt0-x242.google.com with SMTP id w12so2006045qta.2
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 16:32:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170626220330.6785-1-laurent@vivier.eu>
	<20170626220330.6785-8-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <57e29fef-4f84-97ab-528c-bd6c8de63736@twiddle.net>
Date: Mon, 26 Jun 2017 16:32:33 -0700
MIME-Version: 1.0
In-Reply-To: <20170626220330.6785-8-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/7] target/m68k: add fmovem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/26/2017 03:03 PM, Laurent Vivier wrote:
> +static int  cpu_st_float64_ra(CPUM68KState *env, uint32_t addr, FPReg *fp,

Extra space.  Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
