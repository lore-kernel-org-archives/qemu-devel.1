Received: from eggs.gnu.org ([2001:4830:134:3::10]:49791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUekF-0001ig-PN
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUekF-0004LB-5K
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:53:23 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170710192128.9048-1-alex.bennee@linaro.org>
	<20170710192128.9048-4-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <82189fae-76cf-0f28-50ae-5150cd595176@twiddle.net>
Date: Mon, 10 Jul 2017 09:52:12 -1000
MIME-Version: 1.0
In-Reply-To: <20170710192128.9048-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/5] target/arm/translate.h: expand
 comment on DISAS_EXIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org
Cc: qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>

On 07/10/2017 09:21 AM, Alex Bennée wrote:
> We already have an exit condition, DISAS_UPDATE which will exit the
> run-loop. Expand on the difference with DISAS_EXIT in the comments.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/arm/translate.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
