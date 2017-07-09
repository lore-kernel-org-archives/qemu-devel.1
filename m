Received: from eggs.gnu.org ([2001:4830:134:3::10]:52959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIYG-0005kI-SE
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIYD-0007zY-MK
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:11:32 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:35675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUIYD-0007zH-Gj
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:11:29 -0400
Received: by mail-pf0-x232.google.com with SMTP id c73so39625336pfk.2
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 13:11:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-9-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <630d43e5-0fd9-1150-67c6-2255a0cd1ebf@twiddle.net>
Date: Sun, 9 Jul 2017 10:02:34 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-9-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/22] tcg/mips: constify
 tcg_target_callee_save_regs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   tcg/mips/tcg-target.inc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
