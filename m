Received: from eggs.gnu.org ([2001:4830:134:3::10]:35868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTL0z-0007r7-IF
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTL0w-0002Qh-NM
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:41:45 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:39354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTL0w-0002QP-IM
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:41:42 -0400
Received: by mail-pf0-x243.google.com with SMTP id r11-v6so2634621pfl.6
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 22:41:42 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <67b52196-aaeb-8f2b-3cd6-b3996aea4aea@linaro.org>
Date: Wed, 13 Jun 2018 19:41:36 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 02/22] comms: include header for
 writev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/13/2018 02:55 AM, Alex Bennée wrote:
> The compiler complains about implicit declarations otherwise.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  comms.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
