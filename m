Received: from eggs.gnu.org ([2001:4830:134:3::10]:43915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQE3Z-00014K-L4
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQE3W-0002DE-IY
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:39:33 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fQE3W-0002Ck-Ad
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:39:30 -0400
Received: by mail-pl0-x241.google.com with SMTP id w17-v6so1743358pll.9
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 08:39:30 -0700 (PDT)
References: <20180604215102.11002-1-programmingkidx@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9b27b1ce-f3da-d8cf-a57a-49f27e2fae0e@linaro.org>
Date: Tue, 5 Jun 2018 08:39:25 -0700
MIME-Version: 1.0
In-Reply-To: <20180604215102.11002-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tcg-target.inc.c: Use byte form of
 xgetbv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org

On 06/04/2018 02:51 PM, John Arbuckle wrote:
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v2 changes:
> - Fixed a spacing issue in the asm() function.

Applied, thanks.


r~
