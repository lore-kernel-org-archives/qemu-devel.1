Received: from eggs.gnu.org ([2001:4830:134:3::10]:40716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEITU-0006XS-8d
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEITT-0002Wf-Iz
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:52:28 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEITT-0002WR-Ef
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:52:27 -0400
Received: by mail-qt0-x242.google.com with SMTP id l39so1989378qtb.1
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 09:52:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-25-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9552cf13-317e-ea9e-919d-67c308856199@twiddle.net>
Date: Fri, 26 May 2017 09:52:23 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-25-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 24/26] target/s390x: implement TEST DECIMAL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/25/2017 02:05 PM, Aurelien Jarno wrote:
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/helper.h      |  1 +
>   target/s390x/insn-data.def |  3 +++
>   target/s390x/mem_helper.c  | 23 +++++++++++++++++++++++
>   target/s390x/translate.c   |  9 +++++++++
>   4 files changed, 36 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
