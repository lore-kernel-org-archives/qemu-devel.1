Received: from eggs.gnu.org ([2001:4830:134:3::10]:37202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTL9T-0003Bc-Pn
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTL9Q-0004Mo-TU
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:50:31 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:33363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTL9Q-0004MS-Na
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:50:28 -0400
Received: by mail-pl0-x243.google.com with SMTP id 6-v6so2341594plb.0
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 22:50:28 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d293c78c-c068-ba50-f4ee-c0a9d4b1d0be@linaro.org>
Date: Wed, 13 Jun 2018 19:50:23 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 06/22] Makefile: include
 risu_reginfo_$(ARCH) in HDRS
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
> Otherwise changes to reginfo don't cause the whole thing to be
> re-built causing much confusion when bisecting.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
