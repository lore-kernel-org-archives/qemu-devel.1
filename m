Received: from eggs.gnu.org ([2001:4830:134:3::10]:36785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDf8g-0006QM-Jo
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDf8f-000702-TD
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:52:22 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDf8f-0006zs-OC
	for qemu-devel@nongnu.org; Wed, 24 May 2017 18:52:21 -0400
Received: by mail-qt0-x244.google.com with SMTP id l39so28215161qtb.1
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 15:52:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170516224721.13832-1-aurelien@aurel32.net>
	<20170516224721.13832-4-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c00c4c1a-498f-55b3-dced-db70ab762e02@twiddle.net>
Date: Wed, 24 May 2017 15:52:17 -0700
MIME-Version: 1.0
In-Reply-To: <20170516224721.13832-4-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] target/sh4: introduce DELAY_SLOT_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/16/2017 03:47 PM, Aurelien Jarno wrote:
> This will make easier the introduction of a new flag in the next
> patches.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/cpu.h       |  3 ++-
>   target/sh4/helper.c    |  4 ++--
>   target/sh4/translate.c | 17 ++++++++---------
>   3 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
