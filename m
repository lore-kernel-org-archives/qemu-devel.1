Received: from eggs.gnu.org ([2001:4830:134:3::10]:36734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTL6U-00024l-8r
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTL6R-0003nD-7f
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:47:26 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:43858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTL6R-0003mq-0b
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:47:23 -0400
Received: by mail-pl0-x243.google.com with SMTP id c41-v6so2873003plj.10
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 22:47:22 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a24ec09d-9bf8-ea12-092f-9df1d4ad7786@linaro.org>
Date: Wed, 13 Jun 2018 19:47:17 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 05/22] risu: add zlib indication to
 help text
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
> This is a simple aide-memoir as it can be tricky to determine this
> with a simple statically compiled binary.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  risu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Eh, sure.  Or we could simply require zlib...

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
