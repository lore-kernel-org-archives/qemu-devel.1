Received: from eggs.gnu.org ([2001:4830:134:3::10]:43402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbZp7-0002w2-Dx
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbZp4-0007Ce-Bx
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:30:45 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:33092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbZp4-0007CZ-6y
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:30:42 -0500
Received: by mail-it0-x244.google.com with SMTP id e137so341279itc.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 13:30:42 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-2-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f1b7f704-6453-a9a4-0e34-9bf257facff0@twiddle.net>
Date: Wed, 8 Feb 2017 13:30:33 -0800
MIME-Version: 1.0
In-Reply-To: <20170207005930.28327-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/16] softfloat: define 680x0 specific
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 02/06/2017 04:59 PM, Laurent Vivier wrote:
> CC: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  fpu/softfloat-specialize.h | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
