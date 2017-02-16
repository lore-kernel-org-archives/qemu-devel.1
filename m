Received: from eggs.gnu.org ([2001:4830:134:3::10]:33482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceAsf-0005vQ-L6
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceAse-0002Rv-RL
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:29:09 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ceAse-0002Re-LJ
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 20:29:08 -0500
Received: by mail-pg0-x242.google.com with SMTP id 75so361154pgf.3
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 17:29:08 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-12-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <564a4050-d37e-a741-ca48-29729a97237c@twiddle.net>
Date: Thu, 16 Feb 2017 12:28:59 +1100
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-12-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 11/16] target-m68k: add fmovecr
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
> fmovecr moves a floating point constant from the
> FPU ROM to a floating point register.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/fpu_helper.c | 31 +++++++++++++++++++++++++++++++
>  target/m68k/helper.h     |  1 +
>  target/m68k/translate.c  | 12 +++++++++++-
>  3 files changed, 43 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
