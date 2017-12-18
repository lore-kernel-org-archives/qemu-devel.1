Received: from eggs.gnu.org ([2001:4830:134:3::10]:42136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3Rw-0001G6-0m
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eR3Rr-0001x4-1d
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:59:52 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:40251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eR3Rq-0001wi-Sh
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:59:46 -0500
Received: by mail-pg0-x241.google.com with SMTP id k15so9699295pgr.7
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:59:46 -0800 (PST)
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bd7ea4b2-cf70-46e5-b5a0-8323d0bb1ac7@linaro.org>
Date: Mon, 18 Dec 2017 13:59:41 -0800
MIME-Version: 1.0
In-Reply-To: <20171211125705.16120-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 09/19] fpu/softfloat: define decompose
 structures
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
> These structures pave the way for generic softfloat helper routines
> that will operate on fully decomposed numbers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)

Since I was involved in writing this,

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


r~
