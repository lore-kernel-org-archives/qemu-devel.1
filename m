Received: from eggs.gnu.org ([2001:4830:134:3::10]:50353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fC4xa-0002da-OV
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fC4xY-0003j8-QB
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:06:54 -0400
MIME-Version: 1.0
In-Reply-To: <20180427002651.28356-4-richard.henderson@linaro.org>
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-4-richard.henderson@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 27 Apr 2018 08:06:51 -0700
Message-ID: <CAMo8Bf+z2w5hhdwQ+8zUoTeCUK3iCSeAeirB4tX7FvF8o14-tA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/9] target/xtensa: Use new min/max
 expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Apr 26, 2018 at 5:26 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The generic expanders replace nearly identical code in the translator.
>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/xtensa/translate.c | 50 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 17 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
