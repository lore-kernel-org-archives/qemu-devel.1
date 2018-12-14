Received: from eggs.gnu.org ([2001:4830:134:3::10]:59850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe4K-0000on-DR
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe4E-0000Zw-U5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:23:14 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe4C-0000Ci-IN
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:23:10 -0500
Received: by mail-ot1-x343.google.com with SMTP id n8so4117455otl.6
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:23:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
	<20181214031923.29527-2-richard.henderson@linaro.org>
Message-ID: <d8067248-97a3-1a44-3c5e-6a19f54072c6@linaro.org>
Date: Thu, 13 Dec 2018 21:23:04 -0600
MIME-Version: 1.0
In-Reply-To: <20181214031923.29527-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fixup! target/arm: Move id_aa64mmfr* to
 ARMISARegisters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 12/13/18 9:18 PM, Richard Henderson wrote:
> I didn't get this fix pushed back into the patch set that I actually
> sent last week.  The patch is in target-arm.next, and I'm sure you
> would have eventually seen the error in testing.
> 
> 
> r~
> ---
>  target/arm/kvm64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Oops, didn't clean out the directory before generating the pull.
Obviously this isn't in the branch.


r~
