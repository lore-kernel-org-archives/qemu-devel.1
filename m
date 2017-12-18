Received: from eggs.gnu.org ([2001:4830:134:3::10]:38187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3Np-00061r-Cf
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3No-0007bI-Ij
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:55:37 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:38070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR3No-0007b6-CO
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:55:36 -0500
Received: by mail-pl0-x243.google.com with SMTP id s10so5652755plj.5
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:55:36 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6f681d7b-2677-e01c-064a-2de93bb3fd30@linaro.org>
Date: Mon, 18 Dec 2017 13:54:12 -0800
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 07/19] fpu/softfloat: improve comments
 on ARM NaN propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 12/11/2017 04:56 AM, Alex Bennée wrote:
> Mention the pseudo-code fragment from which this is based and correct
> the spelling of signalling.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat-specialize.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
