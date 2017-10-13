Received: from eggs.gnu.org ([2001:4830:134:3::10]:46816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36h0-000337-N0
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36gv-00044h-Rp
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:36:26 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:54979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e36gv-00044G-Kw
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:36:21 -0400
Received: by mail-pf0-x22d.google.com with SMTP id n89so3614509pfk.11
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 13:36:21 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e56fd3c5-da79-16b0-4f20-ccda7e22dc4c@linaro.org>
Date: Fri, 13 Oct 2017 13:36:17 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 01/30] linux-user/main: support dfilter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
