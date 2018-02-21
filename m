Received: from eggs.gnu.org ([2001:4830:134:3::10]:55556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoa5d-0003ii-Pq
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:30:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoa5Y-0000Ie-To
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:30:05 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:40477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eoa5Y-0000HK-DS
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 14:30:00 -0500
Received: by mail-pl0-x243.google.com with SMTP id i6so1479262plt.7
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 11:30:00 -0800 (PST)
References: <20180220173307.25125-1-laurent@vivier.eu>
	<20180220173307.25125-5-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5787fa91-d9b6-2406-aaaf-e6a25aa0c28a@linaro.org>
Date: Wed, 21 Feb 2018 11:29:55 -0800
MIME-Version: 1.0
In-Reply-To: <20180220173307.25125-5-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/4] linux-user: MIPS set cpu to r6 CPU
 if binary is R6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aaron Sierra <asierra@xes-inc.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Riku Voipio <riku.voipio@iki.fi>, YunQiang Su <syq@debian.org>, Igor Mammedov <imammedo@redhat.com>

On 02/20/2018 09:33 AM, Laurent Vivier wrote:
> From: YunQiang Su <syq@debian.org>
> 
> So here we need to detect the version of binaries and set
> cpu_model for it.
> 
> Signed-off-by: YunQiang Su <syq@debian.org>
> [lv: original patch modified to move code into cpu_get_model()]
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
