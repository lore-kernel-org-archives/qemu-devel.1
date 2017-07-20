Received: from eggs.gnu.org ([2001:4830:134:3::10]:58784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYHGE-0003z6-4r
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYHGA-0008Lg-To
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:37:22 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-14-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1d326bd3-903c-29e0-ae47-995d815c2e53@twiddle.net>
Date: Thu, 20 Jul 2017 09:37:12 -1000
MIME-Version: 1.0
In-Reply-To: <20170720150426.12393-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 13/23]
 target/arm/translate-a64.c: add FP16 FADD to AdvSIMD 3 Same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 07/20/2017 05:04 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/arm/helper-a64.h    | 1 +
>   target/arm/translate-a64.c | 3 +++
>   2 files changed, 4 insertions(+)

Implementation of the helper wound up somewhere else.


r~
