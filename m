Received: from eggs.gnu.org ([2001:4830:134:3::10]:51255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEFdN-0006Mu-Es
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEFdM-00046K-4U
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:50:29 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEFdL-000469-WD
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:50:28 -0400
Received: by mail-qt0-x241.google.com with SMTP id j13so1328905qta.3
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 06:50:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-2-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5f67929c-3cab-0935-4066-95e704b9e0cb@twiddle.net>
Date: Fri, 26 May 2017 06:50:24 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/26] target/s390x: remove dead code in
 translate.c
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
>   target/s390x/translate.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
