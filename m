Received: from eggs.gnu.org ([2001:4830:134:3::10]:48917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqlpC-0005Br-V0
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqlp9-0004CK-LC
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:26:10 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:43746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqlp9-0004Bv-FX
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:26:07 -0500
Received: by mail-pl0-x242.google.com with SMTP id f23-v6so66969plr.10
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 12:26:07 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <994e9571-6cc7-7614-aefa-bc8fb1e16cd7@linaro.org>
Date: Tue, 27 Feb 2018 12:26:03 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/19] armv7m: Forward init-svtor property
 to CPU object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 02/20/2018 10:03 AM, Peter Maydell wrote:
> Create an "init-svtor" property on the armv7m container
> object which we can forward to the CPU object.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armv7m.h | 2 ++
>  hw/arm/armv7m.c         | 6 ++++++
>  2 files changed, 8 insertions(+)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
