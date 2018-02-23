Received: from eggs.gnu.org ([2001:4830:134:3::10]:52859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epCoc-0007by-D6
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epCob-00082b-Jw
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:51:06 -0500
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:38666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epCob-00080z-D3
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:51:05 -0500
Received: by mail-pg0-x235.google.com with SMTP id l24so3324161pgc.5
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 04:51:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-13-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 12:50:43 +0000
Message-ID: <CAFEAcA-x8DgwS4m_3tXjYhxunfi6-fmkkfOX65V4kujm+eXZrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 12/67] target/arm: Implement
 SVE bitwise shift by vector (predicated)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
