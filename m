Received: from eggs.gnu.org ([2001:4830:134:3::10]:52253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CLq-0000o1-B7
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CLp-0007Gq-GY
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:07:22 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8CLp-0007Gi-Bs
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:07:21 -0400
Received: by mail-qt0-x242.google.com with SMTP id j13so1635561qta.3
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 14:07:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-9-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <aa32b2ca-c98f-653b-868c-e01a61d29309@twiddle.net>
Date: Tue, 9 May 2017 14:07:18 -0700
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-9-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/14] target/sh4: fold ctx->bstate =
 BS_BRANCH into gen_conditional_jump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/06/2017 04:14 AM, Aurelien Jarno wrote:
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/translate.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
