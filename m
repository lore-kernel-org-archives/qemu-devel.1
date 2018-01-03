Received: from eggs.gnu.org ([2001:4830:134:3::10]:38276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWqqQ-0002nu-3Y
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWqqN-0008GP-4z
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:45:06 -0500
Received: from mail-pl0-x233.google.com ([2607:f8b0:400e:c01::233]:41934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWqqM-0008El-HT
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:45:02 -0500
Received: by mail-pl0-x233.google.com with SMTP id g2so2005892pli.8
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 13:45:02 -0800 (PST)
References: <20180102234108.32713-1-laurent@vivier.eu>
	<20180102234108.32713-6-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <75ec0796-8fbd-f6d9-ca85-da5926770607@linaro.org>
Date: Wed, 3 Jan 2018 13:44:58 -0800
MIME-Version: 1.0
In-Reply-To: <20180102234108.32713-6-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 05/17] target/m68k: add CPU_LOG_INT trace
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

On 01/02/2018 03:40 PM, Laurent Vivier wrote:
> Display the interrupts/exceptions information
> in QEMU logs (-d int)
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v6: update SR with the content of CCR in the logs

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
