Received: from eggs.gnu.org ([2001:4830:134:3::10]:44569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnYT-0000KF-Bd
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnYS-0000dk-Hf
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:15:49 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnYS-0000dc-DH
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:15:48 -0400
Received: by mail-qk0-x241.google.com with SMTP id y128so13393817qka.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:15:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-23-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c55fd84a-87e2-3256-1d02-6d26e5279658@twiddle.net>
Date: Tue, 30 May 2017 13:15:44 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-23-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 22/29] target/s390x: implement MOVE LONG
 UNICODE
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

On 05/29/2017 12:24 PM, Aurelien Jarno wrote:
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/helper.h      |  1 +
>   target/s390x/insn-data.def |  2 ++
>   target/s390x/mem_helper.c  | 47 ++++++++++++++++++++++++++++++++++++++++------
>   target/s390x/translate.c   | 21 +++++++++++++++++++++
>   4 files changed, 65 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
