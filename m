Received: from eggs.gnu.org ([2001:4830:134:3::10]:51326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIQd-0002sp-B5
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIQZ-0002Av-FF
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:03:39 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUIQZ-0002AO-8p
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:03:35 -0400
Received: by mail-pg0-f50.google.com with SMTP id t186so39289370pgb.1
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 13:03:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-8-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cf7262d1-41e3-486d-7253-b947ed7f0da4@twiddle.net>
Date: Sun, 9 Jul 2017 10:02:25 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-8-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/22] tcg/i386: constify
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

On 07/08/2017 09:49 PM, Emilio G. Cota wrote:
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   tcg/i386/tcg-target.inc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
