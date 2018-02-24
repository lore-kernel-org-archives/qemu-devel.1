Received: from eggs.gnu.org ([2001:4830:134:3::10]:60225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNTO-0006lr-V6
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:13:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNTK-0007ZM-W8
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:13:54 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:38485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epNTK-0007Yr-Ox
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:13:50 -0500
Received: by mail-pl0-x241.google.com with SMTP id d4so5808840pll.5
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 16:13:50 -0800 (PST)
References: <20180223153636.29809-1-alex.bennee@linaro.org>
	<20180223153636.29809-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <63ca260b-f49d-41cd-2eaf-63c938191bf0@linaro.org>
Date: Fri, 23 Feb 2018 16:13:47 -0800
MIME-Version: 1.0
In-Reply-To: <20180223153636.29809-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 17/31] arm/translate-a64: add FP16
 FPRINTx to simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 02/23/2018 07:36 AM, Alex Bennée wrote:
> This adds the full range of half-precision floating point to integral
> instructions.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - fix re-base conflicts
>   - move comment to previous commit
>   - don't double test is_scalar in unallocated checks
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
