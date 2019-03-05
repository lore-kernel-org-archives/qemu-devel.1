Received: from eggs.gnu.org ([209.51.188.92]:59517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LGF-0004nz-MM
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LGF-0004Ol-5u
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:19 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1LGE-0004Od-V4
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:19 -0500
Received: by mail-pg1-x542.google.com with SMTP id 125so6707279pgc.12
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 17:22:18 -0800 (PST)
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <879f55a6-112b-aa2b-08b6-fad74e842c89@linaro.org>
Date: Tue, 5 Mar 2019 14:47:18 -0800
MIME-Version: 1.0
In-Reply-To: <20190305172139.32662-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/12] MAINTAINERS: Add entry for Sphinx
 documentation infrastructure
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
> Add a MAINTAINERS entry for Sphinx documentation infrastructure:
> this doesn't cover actual content, only the machinery we use to
> build the docs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
