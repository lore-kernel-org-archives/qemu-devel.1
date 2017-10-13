Received: from eggs.gnu.org ([2001:4830:134:3::10]:51204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36wr-0007sL-ES
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36wn-0005GD-Iw
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:52:49 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:52073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e36wn-0005F7-D1
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:52:45 -0400
Received: by mail-pf0-x22a.google.com with SMTP id n14so11270250pfh.8
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 13:52:45 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3476d545-ab0a-fb84-d97f-5368ade59b37@linaro.org>
Date: Fri, 13 Oct 2017 13:52:41 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 08/30] softfloat: add half-precision
 expansions for MINMAX fns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> Expand the current helpers to include half-precision functions. The
> includes having f16 version of the compare functions.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  fpu/softfloat.c         |  2 ++
>  include/fpu/softfloat.h | 11 +++++++++++
>  2 files changed, 13 insertions(+)

"This includes..."

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
