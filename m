Received: from eggs.gnu.org ([2001:4830:134:3::10]:45126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiOQ-0006Yc-EY
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiON-0000WR-Aq
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:25:30 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:36541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmiON-0000Vz-4M
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:25:27 -0400
Received: by mail-pg0-x231.google.com with SMTP id r133so11717848pgr.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:25:27 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7eefa11e-5daa-1748-0a0f-ab99c8d1cdf0@linaro.org>
Date: Tue, 29 Aug 2017 08:25:23 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/20] target/arm: Implement new PMSAv8
 behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/22/2017 08:08 AM, Peter Maydell wrote:
> Implement the behavioural side of the new PMSAv8 specification.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 110 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
