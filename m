Received: from eggs.gnu.org ([209.51.188.92]:59387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LFx-0004ao-Vj
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LFx-0004HW-9d
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:01 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:39216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1LFv-0004GJ-DC
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:00 -0500
Received: by mail-pg1-x52b.google.com with SMTP id h8so6945251pgp.6
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 17:21:59 -0800 (PST)
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2abad6f7-9bbe-d2c9-2a0d-c85f1bfa7e82@linaro.org>
Date: Tue, 5 Mar 2019 14:36:17 -0800
MIME-Version: 1.0
In-Reply-To: <20190305172139.32662-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/12] docs: Commit initial files from
 sphinx-quickstart
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
> Commit the initial Sphinx conf.py and skeleton index.rst as
> generated with sphinx-quickstart. We'll update these to
> add QEMU-specific tweaks in subsequent commits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-id: 20190228145624.24885-4-peter.maydell@linaro.org
> ---
>  docs/conf.py   | 168 +++++++++++++++++++++++++++++++++++++++++++++++++
>  docs/index.rst |  20 ++++++
>  2 files changed, 188 insertions(+)
>  create mode 100644 docs/conf.py
>  create mode 100644 docs/index.rst

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
