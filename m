Received: from eggs.gnu.org ([2001:4830:134:3::10]:58825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEGAB-0005vn-Mg
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEGAA-0003AZ-VY
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:24:23 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEGAA-00038w-Rn
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:24:22 -0400
Received: by mail-qk0-x244.google.com with SMTP id o85so1346793qkh.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 07:24:22 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-14-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b57e1894-a22a-b6e8-4c26-b6342b9c6286@twiddle.net>
Date: Fri, 26 May 2017 07:24:16 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-14-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/26] target/s390x: improve 24-bit and
 31-bit addresses write
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
>   target/s390x/mem_helper.c | 37 ++++++++++++++++++++++++++++++-------
>   1 file changed, 30 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
