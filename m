Received: from eggs.gnu.org ([2001:4830:134:3::10]:56999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEG2z-0000FW-OA
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:16:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEG2y-00085T-VK
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:16:57 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEG2y-00083Y-Qj
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:16:56 -0400
Received: by mail-qt0-x244.google.com with SMTP id j13so1424095qta.3
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 07:16:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-11-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <719b4318-d43f-51b0-e628-cf9cc3670e95@twiddle.net>
Date: Fri, 26 May 2017 07:16:53 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-11-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/26] target/s390x: implement MOVE WITH
 OFFSET
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

On 05/25/2017 02:04 PM, Aurelien Jarno wrote:
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/helper.h      |  1 +
>   target/s390x/insn-data.def |  4 ++++
>   target/s390x/mem_helper.c  | 31 +++++++++++++++++++++++++++++++
>   target/s390x/translate.c   |  8 ++++++++
>   4 files changed, 44 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
