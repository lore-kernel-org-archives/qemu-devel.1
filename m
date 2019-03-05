Received: from eggs.gnu.org ([209.51.188.92]:59429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LG3-0004dD-F4
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LG2-0004JG-Q1
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:07 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:44352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1LG2-0004Iz-Jg
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:06 -0500
Received: by mail-pg1-x52f.google.com with SMTP id j3so6935057pgm.11
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 17:22:06 -0800 (PST)
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3f3debd1-47a8-dfc5-01ec-eee0a742f0a1@linaro.org>
Date: Tue, 5 Mar 2019 14:42:02 -0800
MIME-Version: 1.0
In-Reply-To: <20190305172139.32662-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 06/12] docs/conf.py: Don't include rST
 sources in HTML build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 3/5/19 9:21 AM, Peter Maydell wrote:
> Sphinx defaults to including all the rST source files
> in the HTML build and making each HTML page link to the
> source file. Disable that.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-id: 20190228145624.24885-7-peter.maydell@linaro.org
> ---
>  docs/conf.py | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
