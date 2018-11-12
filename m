Received: from eggs.gnu.org ([2001:4830:134:3::10]:59246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM8AW-0007Va-Cr
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM8AR-0000Zh-7S
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:06:04 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55407)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gM8AQ-0000Ak-St
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:05:59 -0500
Received: by mail-wm1-x341.google.com with SMTP id i73-v6so2311225wmd.5
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 01:05:22 -0800 (PST)
References: <20181109173553.22341-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <66ed45c3-65c6-37b6-71ab-6469b1a8e34c@linaro.org>
Date: Mon, 12 Nov 2018 10:05:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181109173553.22341-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix the last Hyp mode bug and turn it
 on for A7, A15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Adam Lackorzynski <adam.lackorzynski@kernkonzept.com>, patches@linaro.org

On 11/9/18 6:35 PM, Peter Maydell wrote:
> Not entirely sure what to do about this for 3.1 -- maybe
> put in the bugfix patch but hold off on actually setting
> the feature bit til 4.0?

I would put them both in for 3.1.


r~
