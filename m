Received: from eggs.gnu.org ([2001:4830:134:3::10]:55361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPYlZ-0000V1-Jq
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPYlV-00054T-HZ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:29:41 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:32816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPYlV-00054G-Cp
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:29:37 -0400
Received: by mail-qk0-x232.google.com with SMTP id r62so8191557qkf.0
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 11:29:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170625192125.9992-1-laurent@vivier.eu>
	<20170625192125.9992-6-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ee97e453-326b-9edd-8b91-86c496c6d70c@twiddle.net>
Date: Mon, 26 Jun 2017 11:29:33 -0700
MIME-Version: 1.0
In-Reply-To: <20170625192125.9992-6-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7] softfloat: define floatx80_round()
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

On 06/25/2017 12:21 PM, Laurent Vivier wrote:
> Add a function to round a floatx80 to the defined precision
> (floatx80_rounding_precision)
> 
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   fpu/softfloat.c         | 15 +++++++++++++++
>   include/fpu/softfloat.h |  1 +
>   2 files changed, 16 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
