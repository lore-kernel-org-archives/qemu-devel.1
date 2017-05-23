Received: from eggs.gnu.org ([2001:4830:134:3::10]:41305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD7ck-0000Gy-JJ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dD7cj-0007ho-Ql
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:05:10 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dD7cj-0007hP-M2
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:05:09 -0400
Date: Tue, 23 May 2017 13:05:08 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170523110508.togmifvk7amy7d4e@aurel32.net>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-25-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170523030312.6360-25-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 24/31] target/s390x: Use unwind data for
 helper_lctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-05-22 20:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/mem_helper.c | 9 +++++----
>  target/s390x/translate.c  | 1 -
>  2 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
