Received: from eggs.gnu.org ([2001:4830:134:3::10]:33716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEI18-0002HZ-GE
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEI14-0007TX-TD
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:23:07 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEI14-0007Ro-OG
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:23:06 -0400
Received: by mail-qk0-x243.google.com with SMTP id k74so1762424qke.2
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 09:23:04 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-21-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b8ef3780-b536-152f-24c7-7767fc1a87ab@twiddle.net>
Date: Fri, 26 May 2017 09:23:01 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-21-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/26] target/s390x: implement PACK ASCII
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
>   target/s390x/mem_helper.c  | 35 +++++++++++++++++++++++++++++++++++
>   target/s390x/translate.c   | 16 ++++++++++++++++
>   4 files changed, 54 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
