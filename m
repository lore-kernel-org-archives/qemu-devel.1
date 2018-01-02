Received: from eggs.gnu.org ([2001:4830:134:3::10]:49771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPnb-0005d9-J8
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPna-00078P-Vi
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:52:23 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:46758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWPna-00077b-Pw
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:52:22 -0500
Received: by mail-pl0-x241.google.com with SMTP id i6so28976327plt.13
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 08:52:22 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-10-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8d24c10f-c688-c3a7-1a60-b709f02e1081@linaro.org>
Date: Tue, 2 Jan 2018 08:52:18 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-10-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 09/17] target/m68k: softmmu cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/01/2018 05:10 PM, Laurent Vivier wrote:
> don't compile supervisor only instructions in linux-user mode
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
