Received: from eggs.gnu.org ([2001:4830:134:3::10]:36019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTL1p-0008Le-EQ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTL1m-0002dj-Lu
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:42:37 -0400
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:33813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTL1m-0002dY-Ge
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:42:34 -0400
Received: by mail-pl0-x22f.google.com with SMTP id g20-v6so2881554plq.1
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 22:42:34 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <89c73abc-c27a-0a75-50d3-f75a24938103@linaro.org>
Date: Wed, 13 Jun 2018 19:42:29 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 03/22] build-all-arches: expand the
 range of docker images
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
> We won't actually want power, we want ppc64el for the 64 bit version.
> Also we will soon have m68k so include that as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  build-all-archs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
