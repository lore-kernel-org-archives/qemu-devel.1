Received: from eggs.gnu.org ([2001:4830:134:3::10]:58580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceAhX-0006xe-SG
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceAhW-0006iP-Sj
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:17:39 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ceAhW-0006iJ-NU
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:17:38 -0500
Received: by mail-pg0-x241.google.com with SMTP id 204so341084pge.2
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 17:17:38 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-9-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8521df7c-eaa7-9949-3284-7d2a68f8a764@twiddle.net>
Date: Thu, 16 Feb 2017 12:17:29 +1100
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-9-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/16] target-m68k: define 96bit FP
 registers for gdb on 680x0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 02/07/2017 11:59 AM, Laurent Vivier wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  configure            |  2 +-
>  gdb-xml/m68k-fp.xml  | 21 +++++++++++++++++++++
>  target/m68k/helper.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+), 1 deletion(-)
>  create mode 100644 gdb-xml/m68k-fp.xml

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
