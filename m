Received: from eggs.gnu.org ([208.118.235.92]:46146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbta4-0007Ce-81
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbta1-0000HZ-4z
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:45:36 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbta0-0000Gp-Ve
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:45:33 -0500
Received: by mail-pl1-x643.google.com with SMTP id gn14so6797778plb.10
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:45:32 -0800 (PST)
References: <20181221195200.6544-1-cota@braap.org>
	<20181221195200.6544-2-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cfaa866b-8b94-be9b-b09a-4f939d9ac2ff@linaro.org>
Date: Wed, 26 Dec 2018 07:45:22 +1100
MIME-Version: 1.0
In-Reply-To: <20181221195200.6544-2-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] fp-bench: fix update_random_ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 12/22/18 6:51 AM, Emilio G. Cota wrote:
> The second test in the branches is wrong; fix while converting
> to a switch statement, which is easier to get right.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  tests/fp/fp-bench.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Whoops.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
