Received: from eggs.gnu.org ([2001:4830:134:3::10]:41100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEGmT-00085Y-MF
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEGmS-0007tK-Lu
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:03:57 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEGmS-0007rm-IA
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:03:56 -0400
Received: by mail-qk0-x244.google.com with SMTP id o85so1492644qkh.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 08:03:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-15-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <988edfea-efdb-1bbd-7efa-addf6eef9a5a@twiddle.net>
Date: Fri, 26 May 2017 08:03:51 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-15-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/26] target/s390x: improve 24-bit and
 31-bit lengths read/write
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
>   target/s390x/mem_helper.c | 47 +++++++++++++++++++++++++++++++++--------------
>   1 file changed, 33 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
