Received: from eggs.gnu.org ([2001:4830:134:3::10]:59120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWQ1K-0006QE-8L
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:06:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWQ1J-0008Q0-G1
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:06:34 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:45671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWQ1J-0008PB-AA
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:06:33 -0500
Received: by mail-pl0-x244.google.com with SMTP id o2so28978313plk.12
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 09:06:33 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-16-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <874d532b-4b0e-805b-1c47-2e25e4690ecf@linaro.org>
Date: Tue, 2 Jan 2018 09:06:29 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-16-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 15/17] target/m68k: add andi/ori/eori to
 SR/CCR
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
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 53 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
