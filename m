Received: from eggs.gnu.org ([2001:4830:134:3::10]:58250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1flHTL-0001bp-Ki
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1flHTH-0000Uc-J5
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:33:11 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1flHTH-0000Sc-BK
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:33:07 -0400
Received: by mail-oi0-x242.google.com with SMTP id y207-v6so4995538oie.13
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 10:33:07 -0700 (PDT)
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
	<1533219424-7627-20-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ca8e1d74-6d7e-86b3-3a45-aa60239d3f49@linaro.org>
Date: Thu, 2 Aug 2018 13:32:54 -0400
MIME-Version: 1.0
In-Reply-To: <1533219424-7627-20-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 19/77] target/mips: Add emulation of
 nanoMIPS 16-bit arithmetic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com

On 08/02/2018 10:16 AM, Stefan Markovic wrote:
> From: Yongbok Kim <yongbok.kim@mips.com>
> 
> Add emulation of nanoMIPS 16-bit arithmetic instructions.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
