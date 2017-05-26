Received: from eggs.gnu.org ([2001:4830:134:3::10]:37623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEIJc-00015s-Mm
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEIJc-000785-23
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:42:16 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEIJb-00077z-Td
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:42:15 -0400
Received: by mail-qk0-x244.google.com with SMTP id u75so1809702qka.1
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 09:42:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-23-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2398e82a-8e61-5f8c-acf6-3006bccb9b7f@twiddle.net>
Date: Fri, 26 May 2017 09:42:12 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-23-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/26] target/s390x: implement UNPACK ASCII
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
>   target/s390x/insn-data.def |  2 ++
>   target/s390x/mem_helper.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++
>   target/s390x/translate.c   | 17 ++++++++++++++++
>   4 files changed, 71 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
